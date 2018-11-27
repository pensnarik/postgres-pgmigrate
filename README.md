# postgresql-pgmigrator

## About

This imaage is based on officcial PostgreSQL image but also contains `yandex-pgmigrator` tool.

## Usage

Just mount the directory with migrations into `/db/` directory inside the container:

```
docker run -v /your-migrations:/db -e "POSTGRES_DB=example-db" pensnarik/postgres-pgmigrate
```