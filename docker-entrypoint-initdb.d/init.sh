#!/bin/sh

sed -ri "s/#(listen_addresses) = 'localhost'/\1 = '*'/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(wal_level) = .*/\1 = 'logical'/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_worker_processes) = .*/\1 = 10/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_replication_slots) = .*/\1 = 100/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_wal_senders) = .*/\1 = ${PG_MAX_WAL_SENDERS:-60}/" "${PGDATA}/postgresql.conf"
sed -ri "s/(max_connections) = .*/\1 = ${PG_MAX_CONNECTIONS:-150}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(track_commit_timestamp) = .*/\1 = on/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_min_duration_statement) = .*/\1 = ${PG_LOG_MIN_DURATION_STATEMENT:-0}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_line_prefix) = .*/\1 = '%t: db=%d,user=%u '/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_min_messages) = .*/\1 = ${PG_LOG_MIN_MESSAGES:-warning}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(synchronous_commit) = .*/\1 = ${PG_SYNCHRONOUS_COMMIT:-off}/" "${PGDATA}/postgresql.conf"

pg_ctl -D "${PGDATA}" -w restart

psql -c "CREATE DATABASE shop"
psql -c "create user shop with password 'shop'" shop
psql -c "create user web with password 'web'" shop
psql -c "create user module with password 'module'" shop
psql -c "create user migrator with password 'migrator' superuser;"
psql -c "alter user migrator set search_path to pg_catalog, public;"

pgmigrate -t latest migrate

psql -c '\copy shop.menu from /db/data/shop/menu.sql' shop
psql -c '\copy shop.config from /db/data/shop/config.sql' shop
