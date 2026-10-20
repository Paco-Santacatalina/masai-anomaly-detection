from datetime import datetime, timezone

import pytest

from dataset_builder.zona_horaria import candidatos_utc, resolver_secuencia

UTC = timezone.utc


def test_hora_de_verano_y_de_invierno():
    assert candidatos_utc(datetime(2026, 7, 1, 12, 0)) == (datetime(2026, 7, 1, 10, 0, tzinfo=UTC),)
    assert candidatos_utc(datetime(2026, 1, 15, 12, 0)) == (datetime(2026, 1, 15, 11, 0, tzinfo=UTC),)


def test_hora_inexistente_en_marzo():
    # 29-03-2026: de 02:00 se salta a 03:00
    assert candidatos_utc(datetime(2026, 3, 29, 2, 30)) == ()


def test_hora_repetida_en_octubre():
    # 25-10-2026: de 03:00 se vuelve a 02:00
    assert candidatos_utc(datetime(2026, 10, 25, 2, 30)) == (
        datetime(2026, 10, 25, 0, 30, tzinfo=UTC),
        datetime(2026, 10, 25, 1, 30, tzinfo=UTC),
    )


def test_resolver_secuencia_desambigua_por_orden():
    locales = [
        datetime(2026, 10, 25, 1, 30),
        datetime(2026, 10, 25, 2, 30),  # primera vez (CEST)
        datetime(2026, 10, 25, 2, 15),  # ya es la segunda vez (CET): la primera quedaría atrás
        datetime(2026, 10, 25, 3, 0),
    ]
    assert resolver_secuencia(locales) == [
        datetime(2026, 10, 24, 23, 30, tzinfo=UTC),
        datetime(2026, 10, 25, 0, 30, tzinfo=UTC),
        datetime(2026, 10, 25, 1, 15, tzinfo=UTC),
        datetime(2026, 10, 25, 2, 0, tzinfo=UTC),
    ]


def test_resolver_secuencia_marca_horas_irresolubles():
    locales = [datetime(2026, 3, 29, 1, 0), datetime(2026, 3, 29, 2, 30), datetime(2026, 3, 29, 3, 30)]
    assert resolver_secuencia(locales) == [
        datetime(2026, 3, 29, 0, 0, tzinfo=UTC),
        None,
        datetime(2026, 3, 29, 1, 30, tzinfo=UTC),
    ]


def test_resolver_secuencia_no_descarta_horas_normales_fuera_de_orden():
    # Los solapes de contexto se detectan después; aquí solo se convierte.
    locales = [datetime(2026, 6, 15, 10, 0), datetime(2026, 6, 15, 9, 0)]
    assert resolver_secuencia(locales) == [
        datetime(2026, 6, 15, 8, 0, tzinfo=UTC),
        datetime(2026, 6, 15, 7, 0, tzinfo=UTC),
    ]


def test_candidatos_rechaza_horas_con_zona():
    with pytest.raises(ValueError):
        candidatos_utc(datetime(2026, 7, 1, tzinfo=UTC))
