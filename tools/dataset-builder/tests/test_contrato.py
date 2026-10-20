from datetime import datetime, timedelta, timezone

import pytest

from dataset_builder.contrato import (
    ErrorContrato,
    EscritorCSV,
    ValidadorContrato,
    formatear_ts,
    formatear_valor,
    slug,
)

UTC = timezone.utc


@pytest.mark.parametrize("texto, esperado", [
    ("Bombo 2", "bombo_2"),
    ("Equipo refrigeracion bombo 2", "equipo_refrigeracion_bombo_2"),
    ("EnergiaActivaElectrica", "energia_activa_electrica"),
    ("EnergiaActivaElectrica2", "energia_activa_electrica2"),
    ("%ApertBatCalorUTA_N29", "pct_apert_bat_calor_uta_n29"),
    ("tSetPoinRocioSalidaUTA", "t_set_poin_rocio_salida_uta"),
    ("caudalM3_hInter", "caudal_m3_h_inter"),
    ("PesoCargaBombo_N31 BOMBO", "peso_carga_bombo_n31_bombo"),
    ("Almacén Ñ", "almacen_n"),
    ("UTA2", "uta2"),
])
def test_slug(texto, esperado):
    assert slug(texto) == esperado


def test_slug_rechaza_resultados_invalidos():
    with pytest.raises(ErrorContrato):
        slug("¿?")
    with pytest.raises(ErrorContrato):
        slug("x" * 65)


def test_formatear_ts_convierte_a_utc_con_z():
    madrid_verano = timezone(timedelta(hours=2))
    assert formatear_ts(datetime(2026, 6, 4, 2, 0, 1, 18000, tzinfo=madrid_verano)) == "2026-06-04T00:00:01.018000Z"
    assert formatear_ts(datetime(2026, 6, 4, tzinfo=UTC)) == "2026-06-04T00:00:00Z"


def test_formatear_ts_rechaza_fechas_sin_zona():
    with pytest.raises(ErrorContrato):
        formatear_ts(datetime(2026, 6, 4))


def test_formatear_valor_es_reversible_y_rechaza_no_finitos():
    assert float(formatear_valor(0.1 + 0.2)) == 0.1 + 0.2
    for malo in (float("nan"), float("inf"), float("-inf")):
        with pytest.raises(ErrorContrato):
            formatear_valor(malo)


def test_escritor_reparte_en_partes_con_cabecera(tmp_path):
    escritor = EscritorCSV(tmp_path, "centro_propiedad", max_filas=2)
    for i in range(5):
        escritor.escribir({"centro_id": f"c{i}", "propiedad_id": "p"})
    ficheros = escritor.cerrar()
    assert [f.name for f in ficheros] == [
        "centro_propiedad_0001.csv", "centro_propiedad_0002.csv", "centro_propiedad_0003.csv",
    ]
    assert escritor.filas_por_fichero == [2, 2, 1]
    assert ficheros[2].read_bytes() == b"centro_id,propiedad_id\nc4,p\n"


def test_escritor_sin_filas_deja_solo_cabecera(tmp_path):
    escritor = EscritorCSV(tmp_path, "contexto")
    (fichero,) = escritor.cerrar()
    assert fichero.read_text(encoding="utf-8") == (
        "centro_id,ts_inicio,ts_fin,orden_id,producto_id,turno_id,estado_produccion\n"
    )


def test_escritor_formatea_celdas(tmp_path):
    escritor = EscritorCSV(tmp_path, "propiedades")
    escritor.escribir({"propiedad_id": "p", "nombre": "con, coma", "unidad": "kwh",
                       "tipo_agregacion": "incremental", "es_enpi": False})
    escritor.cerrar()
    assert (tmp_path / "propiedades.csv").read_text(encoding="utf-8").splitlines()[1] == (
        'p,"con, coma",kwh,incremental,false'
    )


def test_escritor_rechaza_columnas_incorrectas(tmp_path):
    with pytest.raises(ErrorContrato):
        EscritorCSV(tmp_path, "centro_propiedad").escribir({"centro_id": "c"})


def _validador_con_catalogo():
    v = ValidadorContrato()
    v.centro({"centro_id": "planta", "centro_padre_id": None, "nombre": "Planta",
              "tipo_equipo": None, "potencia_nominal": None})
    v.centro({"centro_id": "linea", "centro_padre_id": "planta", "nombre": "Línea",
              "tipo_equipo": None, "potencia_nominal": 10.0})
    v.propiedad({"propiedad_id": "energia", "nombre": None, "unidad": "kwh",
                 "tipo_agregacion": "incremental", "es_enpi": False})
    v.centro_propiedad({"centro_id": "linea", "propiedad_id": "energia"})
    return v


def test_validador_exige_padre_definido_antes():
    v = ValidadorContrato()
    with pytest.raises(ErrorContrato, match="padre"):
        v.centro({"centro_id": "hijo", "centro_padre_id": "padre", "nombre": "Hijo",
                  "tipo_equipo": None, "potencia_nominal": None})


def test_validador_rechaza_ids_y_enums_invalidos():
    v = _validador_con_catalogo()
    with pytest.raises(ErrorContrato):
        v.centro({"centro_id": "Mayus", "centro_padre_id": None, "nombre": "x",
                  "tipo_equipo": None, "potencia_nominal": None})
    with pytest.raises(ErrorContrato):
        v.propiedad({"propiedad_id": "otra", "nombre": None, "unidad": "kwh",
                     "tipo_agregacion": "suma", "es_enpi": False})


def test_validador_contexto_detecta_solapes_y_orden():
    v = _validador_con_catalogo()
    t = datetime(2026, 6, 1, tzinfo=UTC)
    base = {"centro_id": "linea", "orden_id": None, "producto_id": None, "turno_id": None,
            "estado_produccion": "produciendo"}
    v.contexto({**base, "ts_inicio": t, "ts_fin": t + timedelta(hours=1)})
    v.contexto({**base, "ts_inicio": t + timedelta(hours=1), "ts_fin": t + timedelta(hours=2)})
    with pytest.raises(ErrorContrato, match="solapado"):
        v.contexto({**base, "ts_inicio": t + timedelta(minutes=90), "ts_fin": t + timedelta(hours=3)})
    with pytest.raises(ErrorContrato, match="ts_fin"):
        v.contexto({**base, "ts_inicio": t + timedelta(hours=5), "ts_fin": t + timedelta(hours=5)})


def test_validador_medida_exige_pareja_registrada():
    v = _validador_con_catalogo()
    t = datetime(2026, 6, 1, tzinfo=UTC)
    v.medida({"ts": t, "centro_id": "linea", "propiedad_id": "energia", "valor": 1.0, "calidad": "good"})
    with pytest.raises(ErrorContrato, match="BR-009"):
        v.medida({"ts": t, "centro_id": "planta", "propiedad_id": "energia", "valor": 1.0, "calidad": "good"})
