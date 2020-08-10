# postgresql-pgmigrator

## About

This image is based on official PostgreSQL image but in addition contains `yandex-pgmigrator` tool.

## Usage

Just mount the directory with migrations into `/db/` directory inside the container:

```
docker run -v /your-migrations:/db -e "POSTGRES_DB=example-db" pensnarik/postgres-pgmigrate
```