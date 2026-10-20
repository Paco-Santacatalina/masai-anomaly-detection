import os

import pytest

from dataset_builder import mesview_export


def test_cli_exige_zona_horaria_en_las_fechas(tmp_path, capsys):
    with pytest.raises(SystemExit):
        mesview_export.main(["--desde", "2026-06-01T00:00:00", "--hasta", "2026-06-02T00:00:00Z",
                             "--salida", str(tmp_path / "s")])
    assert "zona horaria" in capsys.readouterr().err


def test_cli_exige_la_cadena_de_conexion(tmp_path, monkeypatch, capsys):
    monkeypatch.delenv("MESVIEW_DSN", raising=False)
    with pytest.raises(SystemExit):
        mesview_export.main(["--desde", "2026-06-01T00:00:00Z", "--hasta", "2026-06-02T00:00:00Z",
                             "--salida", str(tmp_path / "s")])
    assert "MESVIEW_DSN" in capsys.readouterr().err


def test_env_file_no_pisa_variables_existentes(tmp_path, monkeypatch):
    fichero = tmp_path / ".env"
    fichero.write_text('# comentario\nMESVIEW_DSN="host=x"\nOTRA=1\n', encoding="utf-8")
    monkeypatch.delenv("MESVIEW_DSN", raising=False)
    monkeypatch.setenv("OTRA", "original")
    mesview_export._cargar_env_file(fichero)
    assert os.environ["MESVIEW_DSN"] == "host=x"
    assert os.environ["OTRA"] == "original"
