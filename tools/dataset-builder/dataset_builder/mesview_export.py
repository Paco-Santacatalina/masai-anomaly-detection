"""Exportador MESView → CSV del contrato de T3.2 (F-001, BLK-007, FR-013).

Lee la BD de MESView en solo lectura (ADR-004, revisión 2026-10-20) y genera,
en el directorio de salida:

- `centros.csv`: cada `equipo` es un centro (slug del nombre, jerarquía de
  `equipopadre_fk`; ADR-003 punto 3, revisión D-17);
- `propiedades.csv` y `centro_propiedad.csv`: desde `equipoclasepropiedad`,
  con el `tipo_agregacion` declarado en `propiedadfamilia` (D-18);
- `contexto.csv`: desde `medidahist`, asignado a equipos por el mapeo de la
  configuración y convertido de Europe/Madrid a UTC (D-14, BR-013);
- `medidas[_NNNN].csv`: desde `equipopropiedadvalor`, aplicando
  `factor_multiplicativo` y `factor_offset`, con `calidad = good` (D-15, D-19);
- `informe.json`: recuentos, descartes por motivo, avisos y sha256 de cada CSV.

Uso:
    python -m dataset_builder.mesview_export --desde 2026-06-01T00:00:00Z \\
        --hasta 2026-09-01T00:00:00Z --salida ../../data/mesview

La conexión se toma de la variable de entorno `MESVIEW_DSN` (cadena libpq).
"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import shutil
import sys
import tomllib
from collections import Counter, defaultdict
from collections.abc import Callable, Iterable, Iterator
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Protocol
from zoneinfo import ZoneInfo

from dataset_builder.contrato import (
    ESTADOS_PRODUCCION,
    TIPOS_AGREGACION,
    ErrorContrato,
    EscritorCSV,
    ValidadorContrato,
    formatear_ts,
    slug,
)
from dataset_builder.zona_horaria import resolver_secuencia

RUTA_CONFIG_POR_DEFECTO = Path(__file__).resolve().parent.parent / "mesview_export.toml"


class ErrorExportacion(RuntimeError):
    """La exportación no puede continuar (configuración, datos o salida)."""


# --------------------------------------------------------------------------- modelo

@dataclass(frozen=True)
class Equipo:
    id: int
    nombre: str
    padre_id: int | None
    clase: str


@dataclass(frozen=True)
class Mapeo:
    """Una fila de `equipopropiedad` con variable asociada."""
    equipo_id: int
    variable_id: int
    factor: float | None
    offset: float | None
    clase: str
    propiedad: str
    descripcion: str | None
    unidad: str | None
    tipo_agregacion: str | None


@dataclass(frozen=True)
class IntervaloMES:
    """Una fila de `medidahist`, con horas locales sin zona."""
    centro_mes_id: int
    inicio: datetime
    fin: datetime
    estadotipo_id: int | None
    orden: str | None
    producto: str | None
    turno: str | None


@dataclass(frozen=True)
class Serie:
    centro_id: str
    propiedad_id: str
    variable_id: int
    factor: float | None
    offset: float | None


@dataclass(frozen=True)
class Config:
    zona: ZoneInfo
    centro_mes_a_equipo: dict[int, str]
    estado_produccion: dict[int, str]
    es_enpi: frozenset[str]
    max_filas_por_fichero: int | None


class Fuente(Protocol):
    def equipos(self) -> list[Equipo]: ...
    def mapeos(self) -> list[Mapeo]: ...
    def variables_sin_mapear(self) -> list[tuple[int, str]]: ...
    def intervalos_mes(
        self, centros_mes: list[int], desde_local: datetime, hasta_local: datetime
    ) -> list[IntervaloMES]: ...
    def lecturas(
        self, variable_id: int, desde: datetime, hasta: datetime
    ) -> Iterable[tuple[datetime, float | None]]: ...


# --------------------------------------------------------------------------- configuración

def cargar_config(ruta: Path) -> Config:
    with open(ruta, "rb") as fh:
        datos = tomllib.load(fh)
    ctx = datos.get("contexto", {})
    estados = {int(k): v for k, v in ctx.get("estado_produccion", {}).items()}
    invalidos = {k: v for k, v in estados.items() if v not in ESTADOS_PRODUCCION}
    if invalidos:
        raise ErrorExportacion(f"{ruta}: estado_produccion inválido {invalidos}")
    max_filas = datos.get("salida", {}).get("max_filas_por_fichero")
    if max_filas is not None and (not isinstance(max_filas, int) or max_filas < 1):
        raise ErrorExportacion(f"{ruta}: max_filas_por_fichero debe ser un entero >= 1")
    return Config(
        zona=ZoneInfo(datos.get("zona_horaria_origen", "Europe/Madrid")),
        centro_mes_a_equipo={int(k): v for k, v in ctx.get("centro_mes_a_equipo", {}).items()},
        estado_produccion=estados,
        es_enpi=frozenset(datos.get("propiedades", {}).get("es_enpi", [])),
        max_filas_por_fichero=max_filas,
    )


# --------------------------------------------------------------------------- transformaciones

def construir_centros(equipos: list[Equipo]) -> tuple[list[dict[str, Any]], dict[int, str], list[str]]:
    """Centros en orden padre → hijos, y el `centro_id` de cada equipo."""
    avisos: list[str] = []
    centro_por_equipo: dict[int, str] = {}
    equipo_por_centro: dict[str, int] = {}
    for e in sorted(equipos, key=lambda x: x.id):
        cid = slug(e.nombre)
        if cid in equipo_por_centro:
            raise ErrorExportacion(
                f"los equipos {equipo_por_centro[cid]} y {e.id} generan el mismo centro_id {cid!r}"
            )
        centro_por_equipo[e.id] = cid
        equipo_por_centro[cid] = e.id

    por_id = {e.id: e for e in equipos}
    hijos: dict[int | None, list[Equipo]] = defaultdict(list)
    for e in equipos:
        padre = e.padre_id
        if padre is not None and padre not in por_id:
            avisos.append(f"equipo {e.id} ({e.nombre}): el padre {padre} no existe; se trata como raíz")
            padre = None
        hijos[padre].append(e)

    filas: list[dict[str, Any]] = []
    pendientes = sorted(hijos[None], key=lambda x: centro_por_equipo[x.id])
    while pendientes:
        e = pendientes.pop(0)
        padre = e.padre_id if e.padre_id in por_id else None
        filas.append({
            "centro_id": centro_por_equipo[e.id],
            "centro_padre_id": centro_por_equipo[padre] if padre is not None else None,
            "nombre": e.nombre,
            "tipo_equipo": e.clase,
            "potencia_nominal": None,  # D-15: no hay propiedades estáticas en MESView
        })
        pendientes.extend(sorted(hijos[e.id], key=lambda x: centro_por_equipo[x.id]))
    if len(filas) != len(equipos):
        sin_raiz = sorted(set(centro_por_equipo.values()) - {f["centro_id"] for f in filas})
        raise ErrorExportacion(f"jerarquía de equipos con ciclos: {sin_raiz}")
    return filas, centro_por_equipo, avisos


def construir_propiedades(
    mapeos: list[Mapeo], es_enpi: frozenset[str]
) -> tuple[list[dict[str, Any]], dict[tuple[str, str], str], list[str]]:
    """Propiedades del contrato y el `propiedad_id` de cada (clase, propiedad).

    Las propiedades con el mismo nombre en varias clases comparten id si
    coinciden en unidad y tipo de agregación. Si no coinciden, cada variante
    recibe el sufijo `.<clase>` y se avisa.
    """
    avisos: list[str] = []
    definiciones: dict[tuple[str, str], dict[str, Any]] = {}
    for m in mapeos:
        clave = (m.clase, m.propiedad)
        d = definiciones.setdefault(
            clave, {"unidades": set(), "tipos": set(), "nombre": m.descripcion or m.propiedad}
        )
        if m.unidad:
            d["unidades"].add(m.unidad)
        d["tipos"].add(m.tipo_agregacion)

    variantes: dict[str, dict[tuple[str, str], tuple[str, str]]] = defaultdict(dict)
    for clave in sorted(definiciones):
        d = definiciones[clave]
        unidades = sorted(d["unidades"])
        if not unidades:
            avisos.append(f"propiedad {clave[1]!r} ({clave[0]}): sin unidad; se exporta vacía")
        elif len(unidades) > 1:
            avisos.append(f"propiedad {clave[1]!r} ({clave[0]}): varias unidades {unidades}; se usa {unidades[0]!r}")
        tipos = sorted(t for t in d["tipos"] if t)
        tipo = tipos[0] if tipos else "magnitud"
        if not tipos:
            avisos.append(f"propiedad {clave[1]!r} ({clave[0]}): sin propiedadfamilia; se exporta como magnitud")
        elif tipo not in TIPOS_AGREGACION:
            raise ErrorExportacion(f"propiedad {clave[1]!r} ({clave[0]}): tipo_agregacion desconocido {tipo!r}")
        variantes[slug(clave[1])][clave] = (unidades[0] if unidades else "", tipo)

    filas: list[dict[str, Any]] = []
    prop_por_clase: dict[tuple[str, str], str] = {}
    for base in sorted(variantes):
        grupo = variantes[base]
        distintas = set(grupo.values())
        for clave, (unidad, tipo) in sorted(grupo.items()):
            pid = base if len(distintas) == 1 else f"{base}.{slug(clave[0])}"
            prop_por_clase[clave] = pid
            if any(f["propiedad_id"] == pid for f in filas):
                continue
            filas.append({
                "propiedad_id": pid,
                "nombre": definiciones[clave]["nombre"],
                "unidad": unidad,
                "tipo_agregacion": tipo,
                "es_enpi": pid in es_enpi,
            })
        if len(distintas) > 1:
            avisos.append(f"propiedad {base!r}: unidad o agregación distinta según la clase; se separa por clase")
    filas.sort(key=lambda f: f["propiedad_id"])
    desconocidas = sorted(es_enpi - {f["propiedad_id"] for f in filas})
    if desconocidas:
        avisos.append(f"es_enpi menciona propiedades que no existen: {desconocidas}")
    return filas, prop_por_clase, avisos


def construir_series(
    mapeos: list[Mapeo],
    centro_por_equipo: dict[int, str],
    prop_por_clase: dict[tuple[str, str], str],
) -> tuple[list[Serie], list[dict[str, str]], list[str]]:
    """Una serie por (centro, propiedad) y las parejas de `centro_propiedad`."""
    avisos: list[str] = []
    series: dict[tuple[str, str], Serie] = {}
    for m in sorted(mapeos, key=lambda x: (x.equipo_id, x.variable_id, x.propiedad)):
        if m.equipo_id not in centro_por_equipo:
            avisos.append(f"variable {m.variable_id}: el equipo {m.equipo_id} no existe; se omite")
            continue
        clave = (centro_por_equipo[m.equipo_id], prop_por_clase[(m.clase, m.propiedad)])
        if clave in series:
            avisos.append(
                f"{clave}: ya tiene la variable {series[clave].variable_id}; se omite la {m.variable_id}"
            )
            continue
        series[clave] = Serie(clave[0], clave[1], m.variable_id, m.factor, m.offset)
    ordenadas = [series[k] for k in sorted(series)]
    parejas = [{"centro_id": s.centro_id, "propiedad_id": s.propiedad_id} for s in ordenadas]
    return ordenadas, parejas, avisos


def convertir_lecturas(
    lecturas: Iterable[tuple[datetime, float | None]], serie: Serie, descartes: Counter
) -> Iterator[dict[str, Any]]:
    """Aplica factor y offset. Las lecturas deben llegar ordenadas por `ts`.

    Se descartan (y se cuentan) los valores NULL o no finitos. Si hay varias
    lecturas con el mismo `ts`, se queda la última.
    """
    factor = 1.0 if serie.factor is None else serie.factor
    offset = 0.0 if serie.offset is None else serie.offset
    pendiente: dict[str, Any] | None = None
    for ts, crudo in lecturas:
        if ts.tzinfo is None:
            raise ErrorContrato(f"lectura sin zona horaria en la variable {serie.variable_id}: {ts!r}")
        if crudo is None:
            descartes["valor_nulo"] += 1
            continue
        valor = float(crudo) * factor + offset
        if not math.isfinite(valor):
            descartes["valor_no_finito"] += 1
            continue
        fila = {
            "ts": ts, "centro_id": serie.centro_id, "propiedad_id": serie.propiedad_id,
            "valor": valor, "calidad": "good",
        }
        if pendiente is not None and pendiente["ts"] == ts:
            descartes["ts_duplicado"] += 1
        elif pendiente is not None:
            yield pendiente
        pendiente = fila
    if pendiente is not None:
        yield pendiente


def descendientes(equipos: list[Equipo], raiz_id: int) -> list[int]:
    hijos: dict[int | None, list[int]] = defaultdict(list)
    for e in equipos:
        hijos[e.padre_id].append(e.id)
    resultado, pila = [], [raiz_id]
    while pila:
        actual = pila.pop()
        resultado.append(actual)
        pila.extend(hijos[actual])
    return resultado


def construir_contexto(
    intervalos: list[IntervaloMES],
    equipos: list[Equipo],
    centro_por_equipo: dict[int, str],
    config: Config,
    desde: datetime,
    hasta: datetime,
) -> tuple[list[dict[str, Any]], Counter, list[str]]:
    """Contexto productivo por centro, en UTC, sin solapes (BR-007).

    El contexto de cada centro MES se copia al equipo de `centro_mes_a_equipo`
    y a todos sus descendientes. Se conservan los intervalos que se solapan
    con [desde, hasta), sin recortarlos.
    """
    descartes: Counter = Counter()
    avisos: list[str] = []
    por_nombre = {e.nombre: e.id for e in equipos}
    destinos: dict[int, list[str]] = {}
    for centro_mes, nombre in sorted(config.centro_mes_a_equipo.items()):
        if nombre not in por_nombre:
            avisos.append(f"centro MES {centro_mes}: no existe el equipo {nombre!r}; se omite su contexto")
            continue
        destinos[centro_mes] = sorted(centro_por_equipo[i] for i in descendientes(equipos, por_nombre[nombre]))

    filas: list[dict[str, Any]] = []
    por_centro_mes: dict[int, list[IntervaloMES]] = defaultdict(list)
    for iv in intervalos:
        por_centro_mes[iv.centro_mes_id].append(iv)
    for centro_mes, lista in sorted(por_centro_mes.items()):
        if centro_mes not in destinos:
            continue
        lista.sort(key=lambda iv: (iv.inicio, iv.fin))
        secuencia = [t for iv in lista for t in (iv.inicio, iv.fin)]
        utc = resolver_secuencia(secuencia, config.zona)
        ultimo_fin: datetime | None = None
        for k, iv in enumerate(lista):
            ini, fin = utc[2 * k], utc[2 * k + 1]
            if ini is None or fin is None:
                descartes["hora_local_no_resoluble"] += 1
                continue
            if fin <= ini:
                descartes["intervalo_vacio"] += 1
                continue
            if fin <= desde or ini >= hasta:
                continue
            estado = config.estado_produccion.get(iv.estadotipo_id) if iv.estadotipo_id is not None else None
            if estado is None:
                descartes["estadotipo_sin_mapear"] += 1
                continue
            if ultimo_fin is not None and ini < ultimo_fin:
                descartes["intervalo_solapado"] += 1
                continue
            ultimo_fin = fin
            for cid in destinos[centro_mes]:
                filas.append({
                    "centro_id": cid, "ts_inicio": ini, "ts_fin": fin,
                    "orden_id": iv.orden, "producto_id": iv.producto, "turno_id": iv.turno,
                    "estado_produccion": estado,
                })
    filas.sort(key=lambda f: (f["centro_id"], f["ts_inicio"]))
    return filas, descartes, avisos


# --------------------------------------------------------------------------- exportación

def _sha256(ruta: Path) -> str:
    h = hashlib.sha256()
    with open(ruta, "rb") as fh:
        for bloque in iter(lambda: fh.read(1 << 20), b""):
            h.update(bloque)
    return h.hexdigest()


def _preparar_salida(salida: Path) -> Path:
    if salida.exists() and any(salida.iterdir()) and not (salida / "informe.json").exists():
        raise ErrorExportacion(
            f"{salida} no está vacío y no contiene una exportación anterior (informe.json); no se sobrescribe"
        )
    temporal = salida.with_name(salida.name + ".tmp")
    if temporal.exists():
        shutil.rmtree(temporal)
    temporal.mkdir(parents=True)
    return temporal


def exportar(
    fuente: Fuente,
    config: Config,
    desde: datetime,
    hasta: datetime,
    salida: Path,
    registro: Callable[[str], None] = lambda _m: None,
) -> dict[str, Any]:
    """Genera los CSV del contrato y `informe.json` en `salida`.

    Escribe primero en `<salida>.tmp` y solo sustituye `salida` si todo ha ido
    bien. Los CSV son deterministas; `informe.json` incluye la fecha de
    generación.
    """
    if desde.tzinfo is None or hasta.tzinfo is None:
        raise ErrorExportacion("desde y hasta deben llevar zona horaria")
    if desde >= hasta:
        raise ErrorExportacion("desde debe ser anterior a hasta")
    salida = Path(salida)
    temporal = _preparar_salida(salida)
    try:
        informe = _exportar_en(fuente, config, desde, hasta, temporal, registro)
        if salida.exists():
            shutil.rmtree(salida)
        temporal.rename(salida)
        return informe
    except BaseException:
        shutil.rmtree(temporal, ignore_errors=True)
        raise


def _exportar_en(fuente, config, desde, hasta, directorio, registro) -> dict[str, Any]:
    avisos: list[str] = []
    descartes: Counter = Counter()

    registro("Leyendo catálogo de equipos y propiedades…")
    equipos = fuente.equipos()
    mapeos = fuente.mapeos()
    centros, centro_por_equipo, a = construir_centros(equipos)
    avisos += a
    propiedades, prop_por_clase, a = construir_propiedades(mapeos, config.es_enpi)
    avisos += a
    series, parejas, a = construir_series(mapeos, centro_por_equipo, prop_por_clase)
    avisos += a

    registro("Leyendo contexto productivo (medidahist)…")
    margen = timedelta(days=1)
    desde_local = desde.astimezone(config.zona).replace(tzinfo=None) - margen
    hasta_local = hasta.astimezone(config.zona).replace(tzinfo=None) + margen
    centros_mes = sorted(config.centro_mes_a_equipo)
    intervalos = fuente.intervalos_mes(centros_mes, desde_local, hasta_local) if centros_mes else []
    contexto, d, a = construir_contexto(intervalos, equipos, centro_por_equipo, config, desde, hasta)
    descartes.update({f"contexto.{k}": v for k, v in d.items()})
    avisos += a

    validador = ValidadorContrato()
    ficheros: list[dict[str, Any]] = []

    def volcar(entidad: str, filas: Iterable[dict[str, Any]], validar, max_filas=None) -> int:
        escritor = EscritorCSV(directorio, entidad, max_filas)
        total = 0
        for fila in filas:
            validar(fila)
            escritor.escribir(fila)
            total += 1
        for ruta, n in zip(escritor.cerrar(), escritor.filas_por_fichero or [0]):
            ficheros.append({"fichero": ruta.name, "entidad": entidad, "filas": n})
        return total

    volcar("centros", centros, validador.centro)
    volcar("propiedades", propiedades, validador.propiedad)
    volcar("centro_propiedad", parejas, validador.centro_propiedad)
    volcar("contexto", contexto, validador.contexto)

    resumen_series: list[dict[str, Any]] = []

    def todas_las_medidas() -> Iterator[dict[str, Any]]:
        for i, serie in enumerate(series, 1):
            registro(f"[{i}/{len(series)}] {serie.centro_id} · {serie.propiedad_id} (variable {serie.variable_id})")
            d_serie: Counter = Counter()
            n = 0
            for fila in convertir_lecturas(fuente.lecturas(serie.variable_id, desde, hasta), serie, d_serie):
                n += 1
                yield fila
            descartes.update({f"medidas.{k}": v for k, v in d_serie.items()})
            resumen_series.append({
                "centro_id": serie.centro_id, "propiedad_id": serie.propiedad_id,
                "variable_id": serie.variable_id, "filas": n, "descartes": dict(sorted(d_serie.items())),
            })

    total_medidas = volcar("medidas", todas_las_medidas(), validador.medida, config.max_filas_por_fichero)

    for f in ficheros:
        f["sha256"] = _sha256(directorio / f["fichero"])

    informe = {
        "generado_en": formatear_ts(datetime.now(timezone.utc)),
        "parametros": {
            "desde": formatear_ts(desde),
            "hasta": formatear_ts(hasta),
            "zona_horaria_origen": str(config.zona),
            "centro_mes_a_equipo": {str(k): v for k, v in sorted(config.centro_mes_a_equipo.items())},
            "estado_produccion": {str(k): v for k, v in sorted(config.estado_produccion.items())},
            "max_filas_por_fichero": config.max_filas_por_fichero,
        },
        "recuentos": {
            "centros": len(centros), "propiedades": len(propiedades), "centro_propiedad": len(parejas),
            "contexto": len(contexto), "medidas": total_medidas,
        },
        "ficheros": ficheros,
        "descartes": dict(sorted(descartes.items())),
        "series": resumen_series,
        "series_sin_lecturas": [
            f"{s['centro_id']}·{s['propiedad_id']}" for s in resumen_series if s["filas"] == 0
        ],
        "variables_sin_mapear": [
            {"variable_id": vid, "nombre": nombre} for vid, nombre in fuente.variables_sin_mapear()
        ],
        "avisos": avisos,
    }
    with open(directorio / "informe.json", "w", encoding="utf-8", newline="\n") as fh:
        json.dump(informe, fh, ensure_ascii=False, indent=2)
        fh.write("\n")
    return informe


# --------------------------------------------------------------------------- fuente MESView

SQL_EQUIPOS = """
SELECT e.id, e.nombre, e.equipopadre_fk, ec.nombre
FROM equipo e
JOIN equipoclase ec ON ec.id = e.equipoclase_fk
ORDER BY e.id
"""

SQL_MAPEOS = """
SELECT ep.equipo_fk, ep.variable_industrial_fk, ep.factor_multiplicativo, ep.factor_offset,
       ec.nombre, ecp.nombre, ecp.descripcion,
       COALESCE(u.simbolo, ecp.unidad, ep.unidad),
       pf.tipo_agregacion::text
FROM equipopropiedad ep
JOIN equipoclasepropiedad ecp ON ecp.id = ep.equipoclasepropiedad_fk
JOIN equipoclase ec ON ec.id = ecp.equipoclase_fk
LEFT JOIN unidad u ON u.id = ecp.unidad_fk
LEFT JOIN propiedadfamilia pf ON pf.id = ecp.propiedadfamilia_fk
WHERE ep.variable_industrial_fk IS NOT NULL
ORDER BY ep.equipo_fk, ecp.nombre, ep.variable_industrial_fk
"""

SQL_VARIABLES_SIN_MAPEAR = """
SELECT v.id, v.nombre
FROM variable_industrial v
WHERE NOT EXISTS (SELECT 1 FROM equipopropiedad ep WHERE ep.variable_industrial_fk = v.id)
ORDER BY v.id
"""

SQL_INTERVALOS = """
SELECT mh.centro_fk, mh.finicio, mh.ffin, mh.estadotipo_fk,
       co.codigo, p.codigo, t.identificador
FROM medidahist mh
LEFT JOIN centroorden co ON co.id = mh.centroorden_fk
LEFT JOIN producto p ON p.id = mh.producto_fk
LEFT JOIN turno t ON t.id = mh.turno_fk
WHERE mh.centro_fk = ANY(%s) AND mh.ffin > %s AND mh.finicio < %s
ORDER BY mh.centro_fk, mh.finicio, mh.id
"""

# Usa el índice idx_equipopropiedadvalor_variable_fecha (ADR-004: sin barridos completos).
SQL_LECTURAS = """
SELECT fecha, valor_double
FROM equipopropiedadvalor
WHERE variableindustrial_fk = %s AND fecha >= %s AND fecha < %s
ORDER BY fecha, id
"""


class FuenteMESView:
    """Lectura de MESView en solo lectura con las salvaguardas de ADR-004."""

    def __init__(self, dsn: str, statement_timeout_ms: int = 300_000, itersize: int = 50_000):
        import psycopg
        from psycopg import sql

        self._conn = psycopg.connect(dsn, connect_timeout=15, application_name="t32-mesview-export")
        self._conn.read_only = True
        self._itersize = itersize
        with self._conn.cursor() as cur:
            cur.execute("SET default_transaction_read_only = on")
            cur.execute("SET TIME ZONE 'UTC'")
            cur.execute(sql.SQL("SET statement_timeout = {}").format(sql.Literal(int(statement_timeout_ms))))
        self._conn.commit()

    def __enter__(self) -> FuenteMESView:
        return self

    def __exit__(self, *_exc) -> None:
        self._conn.close()

    def _todas(self, consulta: str, parametros: tuple = ()) -> list[tuple]:
        with self._conn.cursor() as cur:
            cur.execute(consulta, parametros)
            filas = cur.fetchall()
        self._conn.commit()
        return filas

    def equipos(self) -> list[Equipo]:
        return [Equipo(*f) for f in self._todas(SQL_EQUIPOS)]

    def mapeos(self) -> list[Mapeo]:
        return [Mapeo(*f) for f in self._todas(SQL_MAPEOS)]

    def variables_sin_mapear(self) -> list[tuple[int, str]]:
        return [(f[0], f[1]) for f in self._todas(SQL_VARIABLES_SIN_MAPEAR)]

    def intervalos_mes(self, centros_mes, desde_local, hasta_local) -> list[IntervaloMES]:
        filas = self._todas(SQL_INTERVALOS, (list(centros_mes), desde_local, hasta_local))
        return [IntervaloMES(*f) for f in filas]

    def lecturas(self, variable_id, desde, hasta) -> Iterator[tuple[datetime, float | None]]:
        with self._conn.cursor(name=f"lecturas_{variable_id}") as cur:
            cur.itersize = self._itersize
            cur.execute(SQL_LECTURAS, (variable_id, desde, hasta))
            yield from cur
        self._conn.commit()


# --------------------------------------------------------------------------- CLI

def _cargar_env_file(ruta: Path) -> None:
    """Carga `CLAVE=valor` de un fichero sin pisar variables ya definidas."""
    for linea in ruta.read_text(encoding="utf-8").splitlines():
        linea = linea.strip()
        if not linea or linea.startswith("#") or "=" not in linea:
            continue
        clave, valor = linea.split("=", 1)
        os.environ.setdefault(clave.strip(), valor.strip().strip('"').strip("'"))


def _fecha_con_zona(texto: str) -> datetime:
    dt = datetime.fromisoformat(texto)
    if dt.tzinfo is None:
        raise argparse.ArgumentTypeError(f"{texto!r} no lleva zona horaria (usa p. ej. 2026-06-01T00:00:00Z)")
    return dt


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Exporta datos de MESView a los CSV del contrato de T3.2.")
    parser.add_argument("--desde", required=True, type=_fecha_con_zona, help="inicio (incluido), ISO-8601 con zona")
    parser.add_argument("--hasta", required=True, type=_fecha_con_zona, help="fin (excluido), ISO-8601 con zona")
    parser.add_argument("--salida", required=True, type=Path, help="directorio de salida")
    parser.add_argument("--config", type=Path, default=RUTA_CONFIG_POR_DEFECTO)
    parser.add_argument("--env-file", type=Path, help="fichero con MESVIEW_DSN=…")
    parser.add_argument("--dsn-env", default="MESVIEW_DSN", help="variable de entorno con la cadena de conexión")
    args = parser.parse_args(argv)

    if args.env_file:
        _cargar_env_file(args.env_file)
    dsn = os.environ.get(args.dsn_env)
    if not dsn:
        parser.error(f"falta la variable de entorno {args.dsn_env}")

    def registro(mensaje: str) -> None:
        print(mensaje, file=sys.stderr, flush=True)

    try:
        config = cargar_config(args.config)
        with FuenteMESView(dsn) as fuente:
            informe = exportar(fuente, config, args.desde, args.hasta, args.salida, registro)
    except (ErrorExportacion, ErrorContrato) as exc:
        registro(f"ERROR: {exc}")
        return 1
    registro(f"Exportación terminada en {args.salida}: {json.dumps(informe['recuentos'], ensure_ascii=False)}")
    if informe["avisos"]:
        registro(f"{len(informe['avisos'])} avisos; revisa informe.json")
    return 0


if __name__ == "__main__":
    sys.exit(main())
