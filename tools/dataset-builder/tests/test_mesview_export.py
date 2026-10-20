import csv
import json
from collections import Counter
from datetime import datetime, timedelta, timezone
from pathlib import Path
from zoneinfo import ZoneInfo

import pytest

from dataset_builder.mesview_export import (
    RUTA_CONFIG_POR_DEFECTO,
    Config,
    Equipo,
    ErrorExportacion,
    IntervaloMES,
    Mapeo,
    Serie,
    cargar_config,
    construir_centros,
    construir_contexto,
    construir_propiedades,
    convertir_lecturas,
    exportar,
)

UTC = timezone.utc
T0 = datetime(2026, 6, 15, tzinfo=UTC)

# Subconjunto real de la jerarquía de MESView (consulta del 2026-10-20).
EQUIPOS = [
    Equipo(1, "planta Chickles", None, "Agrupacion Equipos"),
    Equipo(8, "Area produccion", 1, "Agrupacion Equipos"),
    Equipo(24, "Bombos", 8, "Agrupacion Equipos"),
    Equipo(9, "Linea Bombo 2", 24, "Agrupacion Equipos"),
    Equipo(5, "Bombo 2", 9, "Bombo recubrimiento"),
    Equipo(23, "Caldera Produccion", 1, "Caldera"),
    Equipo(6, "UTA2", 1, "UTA"),
]

MAPEOS = [
    Mapeo(5, 95, 0.001, 0.0, "Bombo recubrimiento", "EnergiaActivaElectrica", None, "kwh", "incremental"),
    Mapeo(23, 78, 0.001, 0.0, "Caldera", "EnergiaActivaElectrica", None, "kwh", "incremental"),
    Mapeo(6, 3, 0.1, 0.0, "UTA", "%ApertValVaporBatRege_N28", None, "%", "discreto"),
    Mapeo(6, 26, 1.0, None, "UTA", "tSalidaUTA", None, "ºC", "magnitud"),
]

CONFIG = Config(
    zona=ZoneInfo("Europe/Madrid"),
    centro_mes_a_equipo={2: "Linea Bombo 2"},
    estado_produccion={2: "produciendo", 3: "parado", 4: "parado", 5: "parado", 6: "parado"},
    es_enpi=frozenset(),
    max_filas_por_fichero=None,
)


class FuenteMemoria:
    def __init__(self, equipos=EQUIPOS, mapeos=MAPEOS, intervalos=(), lecturas=None):
        self._equipos = list(equipos)
        self._mapeos = list(mapeos)
        self._intervalos = list(intervalos)
        self._lecturas = lecturas or {}
        self.consultas_lecturas = []

    def equipos(self):
        return self._equipos

    def mapeos(self):
        return self._mapeos

    def variables_sin_mapear(self):
        return [(72, "rollingEnergiaActiva")]

    def intervalos_mes(self, centros_mes, desde_local, hasta_local):
        return [iv for iv in self._intervalos
                if iv.centro_mes_id in centros_mes and iv.fin > desde_local and iv.inicio < hasta_local]

    def lecturas(self, variable_id, desde, hasta):
        self.consultas_lecturas.append((variable_id, desde, hasta))
        return [(ts, v) for ts, v in self._lecturas.get(variable_id, []) if desde <= ts < hasta]


def _leer(ruta: Path) -> list[dict]:
    with open(ruta, encoding="utf-8", newline="") as fh:
        return list(csv.DictReader(fh))


def test_centros_en_orden_padre_hijo_con_slugs():
    filas, por_equipo, avisos = construir_centros(EQUIPOS)
    ids = [f["centro_id"] for f in filas]
    assert ids[0] == "planta_chickles"
    for f in filas:
        if f["centro_padre_id"] is not None:
            assert ids.index(f["centro_padre_id"]) < ids.index(f["centro_id"])
    assert por_equipo[5] == "bombo_2"
    assert next(f for f in filas if f["centro_id"] == "bombo_2")["centro_padre_id"] == "linea_bombo_2"
    assert next(f for f in filas if f["centro_id"] == "bombo_2")["tipo_equipo"] == "Bombo recubrimiento"
    assert avisos == []


def test_centros_falla_si_dos_equipos_dan_el_mismo_slug():
    with pytest.raises(ErrorExportacion, match="mismo centro_id"):
        construir_centros([Equipo(1, "Bombo 2", None, "x"), Equipo(2, "bombo  2", None, "x")])


def test_centros_detecta_ciclos():
    with pytest.raises(ErrorExportacion, match="ciclos"):
        construir_centros([Equipo(1, "A", 2, "x"), Equipo(2, "B", 1, "x")])


def test_propiedades_comparten_id_entre_clases_y_respetan_mesview():
    filas, por_clase, _ = construir_propiedades(MAPEOS, frozenset())
    por_id = {f["propiedad_id"]: f for f in filas}
    assert por_clase[("Caldera", "EnergiaActivaElectrica")] == "energia_activa_electrica"
    assert por_clase[("Bombo recubrimiento", "EnergiaActivaElectrica")] == "energia_activa_electrica"
    assert por_id["energia_activa_electrica"]["tipo_agregacion"] == "incremental"
    # D-18: la apertura se exporta como discreto porque así la declara MESView
    assert por_id["pct_apert_val_vapor_bat_rege_n28"]["tipo_agregacion"] == "discreto"


def test_propiedades_con_unidad_distinta_se_separan_por_clase():
    mapeos = [
        Mapeo(1, 10, 1, 0, "Caldera", "Temperatura", None, "ºC", "magnitud"),
        Mapeo(2, 11, 1, 0, "UTA", "Temperatura", None, "K", "magnitud"),
    ]
    filas, por_clase, avisos = construir_propiedades(mapeos, frozenset())
    assert sorted(f["propiedad_id"] for f in filas) == ["temperatura.caldera", "temperatura.uta"]
    assert any("se separa por clase" in a for a in avisos)


def test_propiedad_sin_familia_sale_como_magnitud_con_aviso():
    filas, _, avisos = construir_propiedades([Mapeo(1, 10, 1, 0, "UTA", "X", None, None, None)], frozenset())
    assert filas[0]["tipo_agregacion"] == "magnitud"
    assert filas[0]["unidad"] == ""
    assert len(avisos) == 2


def test_convertir_lecturas_aplica_factor_y_descarta_nulos_y_duplicados():
    serie = Serie("uta2", "t", 3, 0.1, 5.0)
    lecturas = [
        (T0, 100.0),
        (T0 + timedelta(seconds=1), None),
        (T0 + timedelta(seconds=2), 200.0),
        (T0 + timedelta(seconds=2), 300.0),  # mismo ts: se queda la última
        (T0 + timedelta(seconds=3), float("nan")),
    ]
    descartes = Counter()
    filas = list(convertir_lecturas(lecturas, serie, descartes))
    assert [(f["ts"], f["valor"]) for f in filas] == [(T0, 15.0), (T0 + timedelta(seconds=2), 35.0)]
    assert all(f["calidad"] == "good" for f in filas)
    assert descartes == Counter(valor_nulo=1, ts_duplicado=1, valor_no_finito=1)


def test_convertir_lecturas_factor_nulo_equivale_a_uno():
    filas = list(convertir_lecturas([(T0, 7.0)], Serie("c", "p", 1, None, None), Counter()))
    assert filas[0]["valor"] == 7.0


def _iv(inicio_local, horas, estadotipo=2, centro=2):
    return IntervaloMES(centro, inicio_local, inicio_local + timedelta(hours=horas), estadotipo, "OF-1", "P-1", "T1")


def test_contexto_se_aplica_a_la_linea_y_sus_descendientes_en_utc():
    _, por_equipo, _ = construir_centros(EQUIPOS)
    intervalos = [_iv(datetime(2026, 6, 15, 8, 0), 2), _iv(datetime(2026, 6, 15, 10, 0), 1, estadotipo=4)]
    filas, descartes, avisos = construir_contexto(
        intervalos, EQUIPOS, por_equipo, CONFIG, T0, T0 + timedelta(days=1)
    )
    assert avisos == [] and not descartes
    assert sorted({f["centro_id"] for f in filas}) == ["bombo_2", "linea_bombo_2"]
    linea = [f for f in filas if f["centro_id"] == "linea_bombo_2"]
    assert linea[0]["ts_inicio"] == datetime(2026, 6, 15, 6, 0, tzinfo=UTC)  # 08:00 CEST
    assert [f["estado_produccion"] for f in linea] == ["produciendo", "parado"]
    assert linea[0]["orden_id"] == "OF-1" and linea[0]["turno_id"] == "T1"


def test_contexto_descarta_solapes_estados_sin_mapear_y_fuera_de_rango():
    _, por_equipo, _ = construir_centros(EQUIPOS)
    intervalos = [
        _iv(datetime(2026, 6, 15, 8, 0), 2),
        _iv(datetime(2026, 6, 15, 9, 0), 2),               # se solapa con el anterior
        _iv(datetime(2026, 6, 15, 12, 0), 1, estadotipo=1),  # RAIZ: sin mapear
        _iv(datetime(2026, 6, 20, 8, 0), 1),               # fuera de [desde, hasta)
        _iv(datetime(2026, 6, 15, 14, 0), 1, centro=99),   # centro MES sin mapeo
    ]
    filas, descartes, _ = construir_contexto(intervalos, EQUIPOS, por_equipo, CONFIG, T0, T0 + timedelta(days=1))
    assert len([f for f in filas if f["centro_id"] == "linea_bombo_2"]) == 1
    assert descartes == Counter(intervalo_solapado=1, estadotipo_sin_mapear=1)


def test_contexto_avisa_si_el_equipo_mapeado_no_existe():
    _, por_equipo, _ = construir_centros(EQUIPOS)
    config = Config(CONFIG.zona, {2: "No existe"}, CONFIG.estado_produccion, frozenset(), None)
    filas, _, avisos = construir_contexto([_iv(datetime(2026, 6, 15, 8), 1)], EQUIPOS, por_equipo, config, T0,
                                          T0 + timedelta(days=1))
    assert filas == [] and "No existe" in avisos[0]


def _fuente_completa():
    lecturas = {
        95: [(T0 + timedelta(minutes=3 * i), 1_051_312_320.0 + 1000 * i) for i in range(5)],
        # una lectura NULL al final
        78: [(T0 + timedelta(minutes=3 * i), 14_696_327.0 + 10 * i) for i in range(3)]
            + [(T0 + timedelta(minutes=9), None)],
        # dos lecturas en el mismo instante (minuto 3)
        3: [(T0 + timedelta(minutes=i), 431.0) for i in range(4)] + [(T0 + timedelta(minutes=3), 432.0)],
        # 26 (tSalidaUTA) sin lecturas
    }
    intervalos = [_iv(datetime(2026, 6, 15, 2, 0), 3), _iv(datetime(2026, 6, 15, 5, 0), 1, estadotipo=5)]
    return FuenteMemoria(intervalos=intervalos, lecturas=lecturas)


def test_exportar_genera_los_csv_del_contrato(tmp_path):
    salida = tmp_path / "mesview"
    fuente = _fuente_completa()
    informe = exportar(fuente, CONFIG, T0, T0 + timedelta(days=1), salida)

    assert sorted(p.name for p in salida.iterdir()) == [
        "centro_propiedad.csv", "centros.csv", "contexto.csv", "informe.json", "medidas.csv", "propiedades.csv",
    ]
    medidas = _leer(salida / "medidas.csv")
    assert list(medidas[0]) == ["ts", "centro_id", "propiedad_id", "valor", "calidad"]
    assert informe["recuentos"] == {
        "centros": 7, "propiedades": 3, "centro_propiedad": 4, "contexto": 4, "medidas": 12,
    }
    bombo = [m for m in medidas if m["centro_id"] == "bombo_2"]
    assert bombo[0] == {"ts": "2026-06-15T00:00:00Z", "centro_id": "bombo_2",
                        "propiedad_id": "energia_activa_electrica", "valor": "1051312.32", "calidad": "good"}
    contexto = _leer(salida / "contexto.csv")
    assert contexto[0]["ts_inicio"] == "2026-06-15T00:00:00Z"  # 02:00 CEST
    assert informe["descartes"] == {"medidas.ts_duplicado": 1, "medidas.valor_nulo": 1}
    apertura = [m for m in medidas if m["propiedad_id"] == "pct_apert_val_vapor_bat_rege_n28"]
    assert apertura[-1]["valor"] == "43.2"  # 432 × 0,1, la última del minuto repetido
    assert informe["series_sin_lecturas"] == ["uta2·t_salida_uta"]
    assert informe["variables_sin_mapear"] == [{"variable_id": 72, "nombre": "rollingEnergiaActiva"}]
    assert all(len(f["sha256"]) == 64 for f in informe["ficheros"])
    assert json.loads((salida / "informe.json").read_text(encoding="utf-8"))["recuentos"] == informe["recuentos"]
    # Solo se consulta el rango pedido, una vez por serie
    assert {c[0] for c in fuente.consultas_lecturas} == {95, 78, 3, 26}
    assert all(c[1:] == (T0, T0 + timedelta(days=1)) for c in fuente.consultas_lecturas)


def test_exportar_es_determinista(tmp_path):
    a, b = tmp_path / "a", tmp_path / "b"
    exportar(_fuente_completa(), CONFIG, T0, T0 + timedelta(days=1), a)
    exportar(_fuente_completa(), CONFIG, T0, T0 + timedelta(days=1), b)
    for csv_a in sorted(a.glob("*.csv")):
        assert csv_a.read_bytes() == (b / csv_a.name).read_bytes()


def test_exportar_reparte_medidas_en_partes(tmp_path):
    config = Config(CONFIG.zona, CONFIG.centro_mes_a_equipo, CONFIG.estado_produccion, frozenset(), 5)
    informe = exportar(_fuente_completa(), config, T0, T0 + timedelta(days=1), tmp_path / "s")
    partes = [f for f in informe["ficheros"] if f["entidad"] == "medidas"]
    assert [(f["fichero"], f["filas"]) for f in partes] == [
        ("medidas_0001.csv", 5), ("medidas_0002.csv", 5), ("medidas_0003.csv", 2),
    ]


def test_exportar_sobrescribe_solo_exportaciones_anteriores(tmp_path):
    salida = tmp_path / "s"
    exportar(_fuente_completa(), CONFIG, T0, T0 + timedelta(days=1), salida)
    exportar(_fuente_completa(), CONFIG, T0, T0 + timedelta(days=1), salida)  # reexportar: permitido

    ajeno = tmp_path / "ajeno"
    ajeno.mkdir()
    (ajeno / "importante.txt").write_text("no tocar")
    with pytest.raises(ErrorExportacion, match="no se sobrescribe"):
        exportar(_fuente_completa(), CONFIG, T0, T0 + timedelta(days=1), ajeno)
    assert (ajeno / "importante.txt").read_text() == "no tocar"


def test_exportar_no_deja_restos_si_falla(tmp_path):
    class FuenteRota(FuenteMemoria):
        def lecturas(self, variable_id, desde, hasta):
            raise RuntimeError("conexión perdida")

    salida = tmp_path / "s"
    with pytest.raises(RuntimeError):
        exportar(FuenteRota(), CONFIG, T0, T0 + timedelta(days=1), salida)
    assert not salida.exists()
    assert not (tmp_path / "s.tmp").exists()


def test_exportar_rechaza_rangos_invalidos(tmp_path):
    with pytest.raises(ErrorExportacion):
        exportar(_fuente_completa(), CONFIG, T0, T0, tmp_path / "s")
    with pytest.raises(ErrorExportacion):
        exportar(_fuente_completa(), CONFIG, datetime(2026, 6, 15), datetime(2026, 6, 16), tmp_path / "s")


def test_config_por_defecto_se_carga():
    config = cargar_config(RUTA_CONFIG_POR_DEFECTO)
    assert config.centro_mes_a_equipo == {2: "Linea Bombo 2"}
    assert config.estado_produccion[2] == "produciendo"
    assert config.max_filas_por_fichero == 2_000_000
