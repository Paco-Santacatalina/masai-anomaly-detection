# Decisiones abiertas

Cada decisión trae una **propuesta por defecto**. Hasta que el equipo la valide se trata como *supuesto* y no se da por confirmada en el código (regla 19). Cuando se cierra, se lleva a un ADR o a la spec de la feature y se marca `CERRADA`.

Última revisión: 2026-10-16 (validación de EXOS).

| ID | Decisión | Bloquea | Propuesta / resolución | Responsable | Estado |
|---|---|---|---|---|---|
| D-01 | Stack backend y mecanismo de UI | B1 | Spring Boot 3 + React/Vite (ADR-002) | EXOS | CERRADA (2026-10-14) |
| D-02 | Dataset piloto | B1 (validación real) | **Hay una tabla de MESView con datos reales.** El volcado `db/mesview/script.sql` solo muestra el modelo. Falta: (1) conseguir una copia de la BD y (2) identificar la tabla y su volumen. Hasta entonces se usan SKAB y la planta sintética (ADR-004) | EXOS | EN CURSO |
| D-03 | Frecuencia de muestreo y ventanas por tipo de variable | B1, B5 | Pendiente de investigar el **flujo Node-RED** que escribe los datos en MESView (frecuencia, deadband o envío por cambio, por variable). Mientras tanto: se admite muestreo irregular, buckets de 15 min y 1 h | EXOS | ABIERTA |
| D-04 | Semántica de `magnitud` / `incremental` / `discreto` | B1 | **`incremental`** = contador acumulado continuo (kWh, m³). **`discreto`** = contador acumulado que crece a saltos enteros (piezas, ciclos, arranques). Los dos se agregan como suma de deltas positivos, con detección de reset. **`magnitud`** = valor instantáneo, agregado con avg/min/max (sin cambios). Ver ADR-005 | EXOS | CERRADA (2026-10-16) |
| D-05 | Fórmula del baseline dinámico | B2 | Mediana y MAD por (centro, propiedad, producto, turno, estado) sobre las últimas N=8 semanas. Si no hay contexto, se usa el baseline por (centro, propiedad, franja horaria). N es configurable | EXOS | CERRADA (2026-10-16) |
| D-06 | Estados y transiciones de una alerta | B3 | nueva → en_revision → {confirmada, descartada}. Se puede reabrir desde descartada. Todas las transiciones quedan auditadas | EXOS | CERRADA (2026-10-16) |
| D-07 | Fórmula de confianza, impacto energético y prioridad | B6 | Propuesta en revisión: impacto = (observado − baseline) × duración × €/kWh; prioridad = confianza × impacto normalizado | EXOS | ABIERTA |
| D-08 | Autenticación y autorización de la API | B3 | Por definir. Hasta entonces F-001 solo se expone en local y sin autenticación | EXOS / MASAI | ABIERTA |
| D-09 | Política de retención y calidad de datos | B1 | Por definir. Supuesto provisional para F-001: las medidas `bad` se guardan pero se excluyen de los agregados. No se borra nada | EXOS | ABIERTA |
| D-10 | Selección de modelos y quién aprueba reglas y promueve modelos | B2, B5, B7 | **Modelos:** primero se evalúan los ya probados con SKAB (ConvAE como principal y LSTMAE como alternativa), con los defectos de F-005 corregidos. **Aprobación y promoción:** está por definir | EXOS / CETECK | PARCIAL |
| D-11 | Observabilidad | B2/B4 | Logs JSON estructurados, `X-Correlation-Id` propagado entre servicios y métricas Micrometer/Prometheus | EXOS | CERRADA (2026-10-16) |
| D-12 | ¿Las tablas de lecturas de MESView son hypertables o tienen continuous aggregates? | B7 (reconciliar ADR-005) | Ver la explicación más abajo. Se resuelve sola al tener la copia de la BD (D-02) | EXOS / MESView | ABIERTA |
| D-13 | Clave de centro y ruta variable → centro | B7 | `centro.codigo` es único y estable. La ruta es `variable_industrial → equipopropiedad → equipo → centroequipo(pordefecto) → centro` | MESView | CERRADA (2026-10-16) |
| D-14 | Zona horaria de los `timestamp` sin zona de MESView | B7 | **Europe/Madrid.** En la sincronización se convierte de forma explícita a UTC y se tiene en cuenta el cambio de hora (en octubre hay una hora que se repite y en marzo una que no existe) | MESView | CERRADA (2026-10-16) |
| D-15 | Origen de `potencia_nominal`, `calidad` y `es_enpi` | B7 | `potencia_nominal`: propiedad EAV en kW, convertida con `unidad.factor`. `calidad`: se deriva y vale `good` salvo que haya una regla de validación. `es_enpi`: catálogo propio alimentado desde `energiaactividad` | EXOS / MESView | CERRADA (2026-10-16) |
| D-16 | Actualizar el texto del documento funcional al aceptar ADR-003 | Doc | Ver la explicación más abajo | EXOS | ABIERTA |

## Aclaraciones

### D-12, en lenguaje llano
En TimescaleDB, una tabla normal de PostgreSQL pasa a ser una **hypertable** cuando se ejecuta `create_hypertable()`. Desde ese momento se particiona por tiempo, lo que hace las consultas mucho más rápidas. Encima de una hypertable se pueden definir **continuous aggregates**: vistas que precalculan agregados por intervalo (por ejemplo, el consumo por hora) y se mantienen actualizadas solas.

El volcado que tenemos no incluye ninguna de las dos cosas. Puede deberse a que la herramienta de exportación no las vuelca, o a que de verdad no existen. Esto importa porque el funcional habla de reutilizar "el patrón de continuous aggregates ya probado". Si existe en MESView, el diseño de ADR-005 debería ser coherente con él.

Con la copia de la BD se comprueba con dos consultas:
```sql
SELECT * FROM timescaledb_information.hypertables;
SELECT * FROM timescaledb_information.continuous_aggregates;
```
No bloquea nada hasta la integración (B7).

### D-16, en lenguaje llano
El documento `docs/T3.2_Deteccion_Anomalias_Definicion_Funcional.md` dice dos cosas que, a la vista del esquema de MESView, conviene corregir:
1. **§6.1** llama `medida` a nuestra tabla de lecturas. ADR-003 propone llamarla **`medida_energia`**, porque en MESView ya existe una tabla `medida` que significa otra cosa: intervalos de estado y producción.
2. **§6.3** dice que la integración mapea `Medida` (MESView) → `medida` (T3.2). En realidad las lecturas de energía de MESView están en otra tabla. Puede que sea la que tiene los datos (D-02); candidatas: `equipopropiedadvalor` o `energiamedida`.

D-16 consiste solo en **editar esos dos párrafos del funcional** para que no contradigan ADR-003. Lo puede hacer Claude cuando aceptes ADR-003 y sepamos qué tabla tiene los datos.
