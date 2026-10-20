# dataset-builder

Herramientas que generan los CSV del contrato de datos de T3.2 (F-001). Nunca escriben en la base de datos: los CSV se cargan con el importador de `svc-energy-rules` (ADR-006).

| Módulo | Qué hace | Bloque |
|---|---|---|
| `dataset_builder/contrato.py` | Formato CSV del contrato: escritura determinista y validación previa a la importación | BLK-006/007 |
| `dataset_builder/zona_horaria.py` | Europe/Madrid sin zona → UTC, con los cambios de hora (D-14, BR-013) | BLK-007 |
| `dataset_builder/mesview_export.py` | Exportador desde MESView | BLK-007 |
| `skab_to_contract`, `synthetic_plant` | Pendientes | BLK-006 |

## Instalación

Python 3.11 o superior (no está en el PATH: usa el del entorno conda `deep-learning` para crear el venv).

```powershell
cd tools/dataset-builder
& "$env:USERPROFILE\miniconda3\envs\deep-learning\python.exe" -m venv .venv
.\.venv\Scripts\python.exe -m pip install -e ".[test]"
.\.venv\Scripts\python.exe -m pytest
```

## Exportador MESView

### Qué lee y qué genera

| Fichero | Origen en MESView | Notas |
|---|---|---|
| `centros.csv` | `equipo` + `equipoclase` | Cada equipo es un centro. `centro_id` = slug del nombre (`Bombo 2` → `bombo_2`), jerarquía de `equipopadre_fk` (ADR-003 punto 3, D-17). Ordenado de padres a hijos |
| `propiedades.csv` | `equipoclasepropiedad` + `unidad` + `propiedadfamilia` | `propiedad_id` = slug del nombre de la propiedad. `tipo_agregacion` tal como lo declara MESView (D-18). `es_enpi` desde la configuración |
| `centro_propiedad.csv` | `equipopropiedad` con variable asociada | Una pareja por serie exportada |
| `contexto.csv` | `medidahist` + `centroorden` + `producto` + `turno` | Se convierte de Europe/Madrid a UTC. El contexto de cada centro MES se copia al equipo mapeado en la configuración y a sus descendientes. `estadotipo` → `estado_produccion` según la configuración (D-20) |
| `medidas.csv` o `medidas_NNNN.csv` | `equipopropiedadvalor` | `valor = valor_double × factor_multiplicativo + factor_offset` (NULL = 1 y 0). `calidad` siempre `good`: no se aplica ninguna validación de rango (D-15, D-19) |
| `informe.json` | — | Parámetros, recuentos, sha256 de cada CSV, descartes por motivo, series sin lecturas, variables sin mapear y avisos |

Qué se descarta y se cuenta en `informe.json`:

- **Medidas:** `valor_double` NULL o no finito. Si hay varias lecturas con el mismo `ts`, se queda la última (`ts_duplicado`).
- **Contexto:**
  - horas locales inexistentes o que no se pueden resolver por orden;
  - intervalos vacíos;
  - `estadotipo` sin mapear;
  - intervalos que se solapan con el anterior.

  Los intervalos que se solapan con el rango pedido se exportan enteros, sin recortarlos.

Las variables con datos que no están en `equipopropiedad` no se exportan. Por ejemplo, los nombres antiguos de algunos contadores antes del 14-17 de junio (`rollingEnergiaActiva`…). Aparecen en `variables_sin_mapear`.

### Salvaguardas al leer de producción (ADR-004, revisión 2026-10-20)

- Usa un usuario dedicado que solo tenga `SELECT` sobre las tablas que se leen.
- La sesión se abre en solo lectura (`read_only`, `default_transaction_read_only = on`), en UTC y con `statement_timeout` de 5 minutos.
- Las medidas se leen variable a variable y solo en el rango pedido, con un cursor de servidor (50 000 filas por bloque) que usa el índice `(variableindustrial_fk, fecha)`.
- No se hacen barridos completos ni `count(*)` sobre `equipopropiedadvalor`.

### Uso

1. Copia `.env.example` a `.env` y rellena `MESVIEW_DSN`. El `.env` está en `.gitignore`.
2. Ejecuta:

   ```powershell
   .\.venv\Scripts\python.exe -m dataset_builder.mesview_export `
       --env-file .env `
       --desde 2026-06-01T00:00:00Z --hasta 2026-09-01T00:00:00Z `
       --salida ..\..\data\mesview
   ```

- `--desde` (incluido) y `--hasta` (excluido) deben llevar zona horaria.
- La salida se escribe primero en `<salida>.tmp` y solo sustituye a `<salida>` si todo termina bien.
- Una exportación anterior se puede sobrescribir. Un directorio con otros ficheros no se toca.
- Los CSV son deterministas: con los mismos datos y la misma configuración salen idénticos byte a byte.

La configuración está en `mesview_export.toml` (zona horaria, mapeo centro MES → equipo, `estado_produccion`, `es_enpi` y partición de las medidas).

### Importación

En el orden del contrato: `centros` → `propiedades` → `centro_propiedad` → `contexto` → `medidas` (todas las partes). Ver la CLI en la spec de F-001.

### Limitaciones conocidas

- Las consultas SQL no se han probado contra una base de datos: los tests usan una fuente en memoria (no hay Docker para un fixture PostgreSQL). Se validarán en la primera exportación real.
- Si se renombra un equipo o una propiedad en MESView, cambia su clave (ADR-003, riesgo aceptado). El exportador falla si dos equipos generan el mismo `centro_id`.
