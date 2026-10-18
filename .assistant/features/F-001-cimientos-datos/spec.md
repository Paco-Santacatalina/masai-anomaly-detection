# F-001 — Functional Specification: Cimientos de datos

Estado: DRAFT (pendiente de validación del equipo)
Fuentes: funcional T3.2 §4–§6, plan inicial §4 (B0/B1) y §6, ADR-003/004/005.

## Objective
Disponer de un almacén TimescaleDB propio con el contrato de datos de T3.2. Debe permitir cargar datasets históricos de forma idempotente y consultar medidas crudas y agregadas por centro, propiedad e intervalo. Es la base para reglas (F-002) y DL (F-005).

## Actors
- **Responsable de datos / desarrollador**: carga datasets (CLI o API).
- **Servicios consumidores**: motor de reglas (F-002), `svc-energy-dl` (F-005), UI (F-003). Consultan medidas.

## Scope
### In scope
- Esquema `t32`: `centro_energetico`, `propiedad_energetica`, `centro_propiedad`, `medida_energia` (hypertable), `contexto_produccion` e `import_lote`.
- Agregados por tipo de variable (ADR-005).
- Importación batch de CSV: catálogo, medidas y contexto.
- API de solo lectura para catálogo y medidas.
- Herramienta `dataset-builder`: SKAB → CSV del contrato, planta sintética y exportador desde una copia local de MESView (FR-013, condicionado a D-02).
- Entorno local con docker-compose.
### Out of scope
- Reglas, alertas, scoring DL y UI.
- Importación Parquet: se convierte a CSV con `dataset-builder`.
- Sincronización con MESView (F-007).
- Autenticación (D-08; F-001 solo se expone en local).
- Edición o borrado de medidas por API.

## Functional requirements
### FR-001 — Catálogo de centros
El sistema almacena `centro_energetico(centro_id, centro_padre_id, nombre, tipo_equipo, potencia_nominal)`, con jerarquía planta → línea → equipo.
### FR-002 — Catálogo de propiedades
El sistema almacena `propiedad_energetica(propiedad_id, nombre, unidad, tipo_agregacion, es_enpi)`.
### FR-003 — Propiedades por centro
El sistema registra qué propiedades mide cada centro (`centro_propiedad`). Se usa para construir el vector de features dinámico.
### FR-004 — Medidas
El sistema almacena `medida_energia(ts, centro_id, propiedad_id, valor, calidad)` en una hypertable, con `ts` en UTC.
### FR-005 — Contexto productivo
El sistema almacena intervalos `contexto_produccion(centro_id, ts_inicio, ts_fin, orden_id, producto_id, turno_id, estado_produccion)`.
### FR-006 — Importación
Se pueden importar ficheros CSV de cada entidad por CLI y por `POST /api/v1/imports`. Cada importación registra un `import_lote` con: fichero, checksum, tipo de entidad, filas leídas, insertadas, duplicadas y rechazadas, errores (hasta 100) y marcas de tiempo.
### FR-007 — Consulta de medidas crudas
`GET /api/v1/centros/{centroId}/medidas` filtra por `propiedad` (una o varias), `desde` y `hasta` (obligatorios). Está paginada y ordenada por `ts`.
### FR-008 — Consulta de medidas agregadas
La misma consulta con `bucket ∈ {15m, 1h}` devuelve agregados según el `tipo_agregacion` de cada propiedad (ADR-005).
### FR-009 — Normalizabilidad
Cada medida se puede consultar con un indicador `normalizable` y, si lo es, con el contexto vigente en su `ts`.
### FR-010 — Consulta de catálogo
`GET /api/v1/centros` (árbol o lista), `GET /api/v1/centros/{id}`, `GET /api/v1/propiedades`.
### FR-011 — Consulta de importaciones
`GET /api/v1/imports/{id}` devuelve el resultado de un lote.
### FR-012 — Dataset builder
`skab_to_contract` y `synthetic_plant` producen los CSV de catálogo, medidas y contexto y un CSV de *ground truth* de anomalías, de forma determinista para una semilla dada.
### FR-013 — Exportador MESView (depende de D-02)
`mesview_export` lee una **copia local** de la BD de MESView y produce los CSV del contrato aplicando:
- la ruta variable → centro de D-13;
- la clave `centro.codigo`;
- la conversión de Europe/Madrid a UTC de D-14;
- `factor_multiplicativo`/`factor_offset`;
- los valores derivados de D-15.

Nunca se conecta con producción.

## Business rules
### BR-001
Todas las marcas de tiempo se almacenan y devuelven en UTC (ISO-8601 con `Z`). Al importar, se rechaza cualquier timestamp sin offset explícito.
### BR-002
`centro_id` y `propiedad_id` son claves de negocio de texto (`^[a-z0-9][a-z0-9_\-.]{0,63}$`), independientes de las PKs de MESView.
### BR-003
Una medida sin `contexto_produccion` vigente **se conserva** y se marca `normalizable = false`. Nunca se descarta por esa razón.
### BR-004
La importación es idempotente. Reimportar una medida con la misma clave (`centro_id`, `propiedad_id`, `ts`) no crea un duplicado y cuenta como `duplicada`.
- **Supuesto:** si el valor difiere, se conserva el original y se cuenta como `conflicto`; no se sobrescribe.
### BR-005
`valor` se almacena en la unidad del catálogo, sin conversiones implícitas.
### BR-006
`calidad ∈ {good, bad, estimado}`. Si falta en el CSV vale `good`. Las medidas `bad` se almacenan y se excluyen de los agregados.
### BR-007
Para un mismo centro no puede haber dos intervalos de contexto solapados. Se considera `[ts_inicio, ts_fin)`, semiabierto.
### BR-008
`estado_produccion ∈ {produciendo, parado, mantenimiento}`.
### BR-009
Una medida solo se acepta si su `centro_id` y su `propiedad_id` existen en el catálogo y la pareja figura en `centro_propiedad`.
- **Supuesto:** si la pareja no figura, se rechaza en lugar de darla de alta automáticamente.
### BR-010
`potencia_nominal`, si se informa, es ≥ 0 y en kW.
### BR-011
Los datos no tienen por qué tener muestreo regular. Los huecos son válidos y no se rellenan.
### BR-012 — Contadores (D-04)
Las propiedades `incremental` (contador continuo) y `discreto` (contador por pasos enteros) se agregan como suma de deltas entre lecturas consecutivas.
- Un delta negativo se trata como reset: el delta es el valor posterior y se cuenta en `resets`.
- En una propiedad `discreto`, un delta no entero se acepta, pero se cuenta como anomalía de dato.
- Las propiedades `magnitud` se agregan con avg, min y max.
### BR-013 — Zona horaria de origen (D-14)
Los datos procedentes de MESView están en Europe/Madrid sin zona y se convierten a UTC en la exportación.
- Las horas que no existen por el cambio de hora de marzo se rechazan.
- Las horas repetidas por el cambio de hora de octubre se resuelven por el orden de las lecturas si se puede. Si no, se marcan como `estimado`.

## Data
Ver `design.md` (pendiente) y el modelo en `contracts/openapi/svc-energy-rules.yaml`.

**Formato CSV:**
- UTF-8, separador `,`, cabecera obligatoria.
- `medidas.csv`: `ts,centro_id,propiedad_id,valor,calidad`.
- `contexto.csv`: `centro_id,ts_inicio,ts_fin,orden_id,producto_id,turno_id,estado_produccion`.
- `centros.csv` y `propiedades.csv` según FR-001/002.
- `centro_propiedad.csv`: `centro_id,propiedad_id`.

## Interfaces
- REST: `contracts/openapi/svc-energy-rules.yaml` (versión 0.1.0, en borrador).
- CLI: `java -jar svc-energy-rules.jar --import --entity=<medidas|contexto|centros|propiedades|centro_propiedad> --file=<path>`.

## Error scenarios
### ERR-001
Fichero con cabecera inválida o columnas que faltan → el lote se rechaza entero (`FAILED`) y se describen las columnas esperadas.
### ERR-002
Fila con timestamp sin offset, mal formado o `valor` no numérico (incluidos NaN e Infinity) → se rechaza la fila con su número de línea y motivo, y el resto continúa.
### ERR-003
Fila con centro o propiedad desconocidos, o pareja no asociada (BR-009) → se rechaza la fila.
### ERR-004
Intervalo de contexto solapado o con `ts_fin <= ts_inicio` → se rechaza la fila.
### ERR-005
Fichero mayor que el límite configurado (por defecto 200 MB) → respuesta `413` y no se crea ningún lote.
### ERR-006
Consulta con `desde >= hasta`, rango mayor que el máximo (por defecto 31 días en crudo y 366 días agregado) o `bucket` inválido → `400` con `ProblemDetail`.
### ERR-007
`centroId` inexistente → `404`.
### ERR-008
Base de datos no disponible → `503` con `ProblemDetail`, sin trazas internas en la respuesta.

## Acceptance criteria
### AC-001
Con la base de datos vacía, `docker compose up` seguido del arranque del servicio deja las migraciones aplicadas y `GET /actuator/health` en `UP`.
### AC-002
Importar el dataset sintético completo (catálogo → centro_propiedad → contexto → medidas) termina con 0 filas rechazadas, y los recuentos coinciden con los generados.
### AC-003
Reimportar el mismo `medidas.csv` inserta 0 filas y cuenta todas como duplicadas (BR-004).
### AC-004
Un CSV con filas inválidas mezcladas (ERR-002/003) inserta las válidas y reporta cada inválida con su línea.
### AC-005
`GET …/medidas?bucket=1h` devuelve el `incremento` correcto, calculado a mano en el test (ADR-005, BR-012), en estos casos:
- contador `incremental` con un reset;
- contador `discreto` con saltos enteros;
- delta que cruza el límite de un bucket.
### AC-006
Una medida fuera de cualquier intervalo de contexto aparece con `normalizable=false`.
### AC-007
La consulta por centro, propiedad e intervalo devuelve solo medidas de ese filtro, ordenadas por `ts` y paginadas.
### AC-008
`synthetic_plant --seed 42` produce ficheros idénticos byte a byte en dos ejecuciones.

## Non-functional requirements
### NFR-001
Rendimiento de importación: ≥ 50 000 medidas/s en local, de forma orientativa (se mide; no bloquea).
### NFR-002
Consulta agregada de 1 centro × 3 propiedades × 30 días a 1 h en menos de 500 ms (p95) con 10 M de filas en la hypertable (orientativo).
### NFR-003
Toda consulta SQL va parametrizada. No se concatena ninguna entrada del usuario.
### NFR-004
Errores en formato RFC 7807, estables y sin trazas internas.
### NFR-005
Los tests de integración se ejecutan contra TimescaleDB real con Testcontainers y la misma imagen fijada que docker-compose.
### NFR-006
Migraciones Flyway versionadas, que se pueden aplicar desde cero.

## Technology constraints
ADR-002 (Spring Boot 3, Flyway, TimescaleDB 2.x / PG16) y ADR-005.

## Open questions
D-02 (copia de la BD y tabla con datos), D-03 (muestreo, flujo Node-RED) y D-09 (retención y calidad), en `OPEN-DECISIONS.md`. D-04, D-13, D-14 y D-15 están cerradas e incorporadas. Además:
- **Q-01:** ¿hace falta una API para dar de alta o editar el catálogo en F-001, o basta con la importación? *Supuesto:* basta con la importación.
- **Q-02:** ¿la importación por API es síncrona? *Supuesto:* síncrona hasta el límite de tamaño; asíncrona en una fase posterior si hiciera falta.

## Assumptions
- Los supuestos de BR-004 y BR-009 y los de Q-01 y Q-02.
- La API de F-001 solo se expone en local y sin autenticación hasta que se cierre D-08.
