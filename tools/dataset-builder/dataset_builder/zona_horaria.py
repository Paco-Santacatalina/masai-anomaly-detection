"""Conversión de horas locales sin zona (MESView, Europe/Madrid) a UTC (D-14, BR-013)."""
from __future__ import annotations

from collections.abc import Sequence
from datetime import datetime, timezone
from zoneinfo import ZoneInfo

MADRID = ZoneInfo("Europe/Madrid")


def candidatos_utc(local: datetime, zona: ZoneInfo = MADRID) -> tuple[datetime, ...]:
    """Instantes UTC que corresponden a una hora local sin zona.

    Devuelve 0 candidatos si la hora no existe (salto de marzo), 1 si es una
    hora normal y 2, ordenados, si se repite (retroceso de octubre).
    """
    if local.tzinfo is not None:
        raise ValueError(f"se esperaba una hora sin zona: {local!r}")
    candidatos = set()
    for fold in (0, 1):
        utc = local.replace(tzinfo=zona, fold=fold).astimezone(timezone.utc)
        if utc.astimezone(zona).replace(tzinfo=None) == local:
            candidatos.add(utc)
    return tuple(sorted(candidatos))


def resolver_secuencia(locales: Sequence[datetime], zona: ZoneInfo = MADRID) -> list[datetime | None]:
    """Convierte una secuencia cronológica de horas locales a UTC.

    Una hora normal se convierte directamente, aunque rompa el orden (los
    solapes se tratan aparte). Una hora repetida se resuelve por el orden: se
    elige el primer candidato que no sea anterior al instante más tardío ya
    resuelto. Si la hora no existe o no hay candidato compatible con el orden,
    devuelve `None` en esa posición.
    """
    resultado: list[datetime | None] = []
    ultimo: datetime | None = None
    for local in locales:
        candidatos = candidatos_utc(local, zona)
        if len(candidatos) == 1:
            elegido = candidatos[0]
        else:
            elegido = next((c for c in candidatos if ultimo is None or c >= ultimo), None)
        resultado.append(elegido)
        if elegido is not None:
            ultimo = elegido if ultimo is None else max(ultimo, elegido)
    return resultado
