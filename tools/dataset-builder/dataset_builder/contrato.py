"""Formato CSV del contrato de datos de T3.2 (spec F-001, sección «Data»).

Módulo común de escritura y validación. Lo usa `mesview_export` y lo
reutilizarán `skab_to_contract` y `synthetic_plant` (BLK-006).

La validación replica las reglas que aplica el importador Java (BR-001,
BR-002, BR-006…BR-009) para detectar errores antes de importar. El importador
sigue siendo la autoridad (ADR-006).
"""
from __future__ import annotations

import csv
import math
import re
import unicodedata
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

PATRON_ID = re.compile(r"^[a-z0-9][a-z0-9_.-]{0,63}$")
TIPOS_AGREGACION = frozenset({"magnitud", "incremental", "discreto"})
CALIDADES = frozenset({"good", "bad", "estimado"})
ESTADOS_PRODUCCION = frozenset({"produciendo", "parado", "mantenimiento"})

COLUMNAS: dict[str, tuple[str, ...]] = {
    "centros": ("centro_id", "centro_padre_id", "nombre", "tipo_equipo", "potencia_nominal"),
    "propiedades": ("propiedad_id", "nombre", "unidad", "tipo_agregacion", "es_enpi"),
    "centro_propiedad": ("centro_id", "propiedad_id"),
    "contexto": (
        "centro_id", "ts_inicio", "ts_fin", "orden_id", "producto_id", "turno_id", "estado_produccion",
    ),
    "medidas": ("ts", "centro_id", "propiedad_id", "valor", "calidad"),
}


class ErrorContrato(ValueError):
    """Una fila no cumple el contrato."""


def slug(texto: str) -> str:
    """Convierte un nombre de MESView en una clave de negocio (BR-002).

    Separa camelCase, quita acentos, sustituye `%` por `pct` y une las palabras
    con `_`: «EnergiaActivaElectrica» → `energia_activa_electrica`,
    «Bombo 2» → `bombo_2`. Falla si el resultado no cumple el patrón, en lugar
    de truncarlo, para no crear colisiones silenciosas.
    """
    s = texto.replace("%", " pct ")
    s = unicodedata.normalize("NFKD", s)
    s = "".join(c for c in s if not unicodedata.combining(c))
    s = re.sub(r"(?<=[a-z0-9])(?=[A-Z])", " ", s)
    s = re.sub(r"(?<=[A-Z])(?=[A-Z][a-z])", " ", s)
    s = re.sub(r"[^a-z0-9]+", "_", s.lower()).strip("_")
    if not PATRON_ID.match(s):
        raise ErrorContrato(f"no se puede generar una clave válida a partir de {texto!r} (resultado {s!r})")
    return s


def formatear_ts(dt: datetime) -> str:
    """ISO-8601 en UTC con sufijo `Z` (BR-001). Rechaza fechas sin zona."""
    if dt.tzinfo is None or dt.utcoffset() is None:
        raise ErrorContrato(f"timestamp sin zona horaria: {dt!r}")
    return dt.astimezone(timezone.utc).replace(tzinfo=None).isoformat() + "Z"


def formatear_valor(valor: float) -> str:
    """Representación exacta y reversible del valor; rechaza NaN e infinitos."""
    v = float(valor)
    if not math.isfinite(v):
        raise ErrorContrato(f"valor no finito: {valor!r}")
    return repr(v)


def _celda(valor: Any) -> str:
    if valor is None:
        return ""
    if isinstance(valor, bool):
        return "true" if valor else "false"
    if isinstance(valor, float):
        return formatear_valor(valor)
    if isinstance(valor, datetime):
        return formatear_ts(valor)
    return str(valor)


class EscritorCSV:
    """Escribe una entidad del contrato en UTF-8, separador `,` y fin de línea LF.

    Con `max_filas` la salida se reparte en `<entidad>_0001.csv`, `_0002`…;
    sin él va a `<entidad>.csv`. La salida es determinista: misma entrada,
    mismos bytes.
    """

    def __init__(self, directorio: Path, entidad: str, max_filas: int | None = None):
        if entidad not in COLUMNAS:
            raise ValueError(f"entidad desconocida: {entidad}")
        if max_filas is not None and max_filas < 1:
            raise ValueError("max_filas debe ser >= 1")
        self.directorio = Path(directorio)
        self.entidad = entidad
        self.columnas = COLUMNAS[entidad]
        self.max_filas = max_filas
        self.ficheros: list[Path] = []
        self.filas_por_fichero: list[int] = []
        self._fh = None
        self._writer = None

    def _abrir_siguiente(self) -> None:
        self._cerrar_actual()
        if self.max_filas is None:
            nombre = f"{self.entidad}.csv"
        else:
            nombre = f"{self.entidad}_{len(self.ficheros) + 1:04d}.csv"
        ruta = self.directorio / nombre
        self._fh = open(ruta, "w", encoding="utf-8", newline="")
        self._writer = csv.writer(self._fh, lineterminator="\n")
        self._writer.writerow(self.columnas)
        self.ficheros.append(ruta)
        self.filas_por_fichero.append(0)

    def _cerrar_actual(self) -> None:
        if self._fh is not None:
            self._fh.close()
            self._fh = None
            self._writer = None

    def escribir(self, fila: dict[str, Any]) -> None:
        if set(fila) != set(self.columnas):
            raise ErrorContrato(f"{self.entidad}: columnas {sorted(fila)} ≠ {list(self.columnas)}")
        if self._writer is None or (
            self.max_filas is not None and self.filas_por_fichero[-1] >= self.max_filas
        ):
            self._abrir_siguiente()
        self._writer.writerow([_celda(fila[c]) for c in self.columnas])
        self.filas_por_fichero[-1] += 1

    def cerrar(self) -> list[Path]:
        if not self.ficheros:
            self._abrir_siguiente()  # fichero solo con cabecera
        self._cerrar_actual()
        return list(self.ficheros)


class ValidadorContrato:
    """Valida las filas en el orden de importación: centros → propiedades →
    centro_propiedad → contexto → medidas.

    Supone que el contexto llega ordenado por (`centro_id`, `ts_inicio`) para
    detectar solapes (BR-007) sin guardar todos los intervalos.
    """

    def __init__(self) -> None:
        self.centros: set[str] = set()
        self.propiedades: set[str] = set()
        self.parejas: set[tuple[str, str]] = set()
        self._ultimo_fin: dict[str, datetime] = {}
        self._ultimo_inicio: dict[str, datetime] = {}

    @staticmethod
    def _id(valor: Any, campo: str) -> str:
        if not isinstance(valor, str) or not PATRON_ID.match(valor):
            raise ErrorContrato(f"{campo} no cumple el patrón de BR-002: {valor!r}")
        return valor

    @staticmethod
    def _ts(valor: Any, campo: str) -> datetime:
        if not isinstance(valor, datetime) or valor.utcoffset() is None:
            raise ErrorContrato(f"{campo} debe ser un datetime con zona: {valor!r}")
        return valor.astimezone(timezone.utc)

    def centro(self, fila: dict[str, Any]) -> None:
        cid = self._id(fila["centro_id"], "centro_id")
        if cid in self.centros:
            raise ErrorContrato(f"centro_id duplicado: {cid}")
        padre = fila["centro_padre_id"]
        if padre is not None:
            self._id(padre, "centro_padre_id")
            if padre not in self.centros:
                raise ErrorContrato(f"centro {cid}: el padre {padre} no se ha definido antes")
        if not fila["nombre"]:
            raise ErrorContrato(f"centro {cid}: nombre vacío")
        pn = fila["potencia_nominal"]
        if pn is not None and (not math.isfinite(pn) or pn < 0):
            raise ErrorContrato(f"centro {cid}: potencia_nominal inválida {pn!r} (BR-010)")
        self.centros.add(cid)

    def propiedad(self, fila: dict[str, Any]) -> None:
        pid = self._id(fila["propiedad_id"], "propiedad_id")
        if pid in self.propiedades:
            raise ErrorContrato(f"propiedad_id duplicado: {pid}")
        if fila["unidad"] is None:
            raise ErrorContrato(f"propiedad {pid}: unidad obligatoria")
        if fila["tipo_agregacion"] not in TIPOS_AGREGACION:
            raise ErrorContrato(f"propiedad {pid}: tipo_agregacion inválido {fila['tipo_agregacion']!r}")
        if not isinstance(fila["es_enpi"], bool):
            raise ErrorContrato(f"propiedad {pid}: es_enpi debe ser booleano")
        self.propiedades.add(pid)

    def centro_propiedad(self, fila: dict[str, Any]) -> None:
        pareja = (fila["centro_id"], fila["propiedad_id"])
        if pareja[0] not in self.centros:
            raise ErrorContrato(f"centro_propiedad: centro desconocido {pareja[0]}")
        if pareja[1] not in self.propiedades:
            raise ErrorContrato(f"centro_propiedad: propiedad desconocida {pareja[1]}")
        if pareja in self.parejas:
            raise ErrorContrato(f"centro_propiedad duplicada: {pareja}")
        self.parejas.add(pareja)

    def contexto(self, fila: dict[str, Any]) -> None:
        cid = fila["centro_id"]
        if cid not in self.centros:
            raise ErrorContrato(f"contexto: centro desconocido {cid}")
        ini = self._ts(fila["ts_inicio"], "ts_inicio")
        fin = self._ts(fila["ts_fin"], "ts_fin")
        if fin <= ini:
            raise ErrorContrato(f"contexto {cid}: ts_fin <= ts_inicio ({ini} – {fin})")
        if fila["estado_produccion"] not in ESTADOS_PRODUCCION:
            raise ErrorContrato(f"contexto {cid}: estado_produccion inválido {fila['estado_produccion']!r}")
        if cid in self._ultimo_inicio and ini < self._ultimo_inicio[cid]:
            raise ErrorContrato(f"contexto {cid}: filas desordenadas en {ini}")
        if cid in self._ultimo_fin and ini < self._ultimo_fin[cid]:
            raise ErrorContrato(f"contexto {cid}: intervalo solapado en {ini} (BR-007)")
        self._ultimo_inicio[cid] = ini
        self._ultimo_fin[cid] = fin

    def medida(self, fila: dict[str, Any]) -> None:
        pareja = (fila["centro_id"], fila["propiedad_id"])
        if pareja not in self.parejas:
            raise ErrorContrato(f"medida: pareja {pareja} no está en centro_propiedad (BR-009)")
        self._ts(fila["ts"], "ts")
        formatear_valor(fila["valor"])
        if fila["calidad"] not in CALIDADES:
            raise ErrorContrato(f"medida: calidad inválida {fila['calidad']!r}")
