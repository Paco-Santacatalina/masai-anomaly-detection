-- F-001 / BLK-001: extensiones requeridas por el esquema t32.
-- El esquema t32 lo crea Flyway (spring.flyway.create-schemas).
-- Las extensiones se instalan en public para no mezclarlas con los objetos del contrato.
-- Requiere privilegios para CREATE EXTENSION: en local el usuario de la imagen los tiene;
-- en entornos gestionados deben crearse fuera de banda (las sentencias son idempotentes).

-- Hypertables y continuous aggregates (V3, V5; ADR-005).
CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;

-- Restricción EXCLUDE de solapes de contexto_produccion por centro_id text (V4, BR-007).
CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;
