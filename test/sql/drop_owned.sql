\c single :ROLE_SUPERUSER
CREATE SCHEMA hypertable_schema;
GRANT ALL ON SCHEMA hypertable_schema TO :ROLE_DEFAULT_PERM_USER;
SET ROLE :ROLE_DEFAULT_PERM_USER;

CREATE TABLE hypertable_schema.test1 (time timestamptz, temp float, location int);
SELECT create_hypertable('hypertable_schema.test1', 'time', 'location', 2);
INSERT INTO hypertable_schema.test1 VALUES ('2001-01-01 01:01:01', 23.3, 1);


RESET ROLE;
CREATE TABLE hypertable_schema.test2 (time timestamptz, temp float, location int);
SELECT create_hypertable('hypertable_schema.test2', 'time', 'location', 2);
INSERT INTO hypertable_schema.test2 VALUES ('2001-01-01 01:01:01', 23.3, 1);

SELECT * FROM _timescaledb_catalog.hypertable ORDER BY id;
SELECT * FROM _timescaledb_catalog.chunk;

DROP OWNED BY :ROLE_DEFAULT_PERM_USER;

SELECT * FROM _timescaledb_catalog.hypertable ORDER BY id;
SELECT * FROM _timescaledb_catalog.chunk;

DROP TABLE  hypertable_schema.test2;

--everything should be cleaned up
SELECT * FROM _timescaledb_catalog.hypertable GROUP BY id;
SELECT * FROM _timescaledb_catalog.chunk;
SELECT * FROM _timescaledb_catalog.dimension;
SELECT * FROM _timescaledb_catalog.dimension_slice;
SELECT * FROM _timescaledb_catalog.chunk_index;
SELECT * FROM _timescaledb_catalog.chunk_constraint;
