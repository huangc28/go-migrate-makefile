## Purpose

Use this tool in pair with [go migrate package](https://github.com/golang-migrate/migrate).

Remove redundant commands of the following migration actions:

- [Create migrations](#create-migrations)
- [Run migrations](#run-migrations)
- [Rollback migrations](#rollback-migrations)

## Usage

Include `go_migrate.mk` in your Makefile:

```
include ./go_migrate.mk
```

or

```
-include ./go_migrate.mk
```

The above ignores the error message if `go_migrate.mk` does not exist.


## Create migrations

```
make migrate_create {migration_name}
```

## Run migrations

```
make migrate_up
```

## Rollback migrations

```
make migrate_down {steps_to_rollback}
```

## Replacing environment variables

`go-migrate-makefile` uses following environment variables as the default setup to run `go-migrate` commands. Following are list of default env vars.

```
DSN_PROTOCOL=postgres
DB_USER:=postgres
DB_HOST:=127.0.0.1
DB_PASSWORD:=1234
DB_DBNAME:=sample
DB_DSN:=$(DSN_PROTOCOL)://$(PG_USER):$(PG_PASSWORD)@$(PG_HOST):$(PG_PORT)/$(PG_DBNAME)?sslmode=disable
```

You can override any of the above to to suite your need:


## Override default DB env variables from your dot env file

Include the following code in your Makefile to replace the default DB env variables.

**.env**

```
DB_USER:=postgres
DB_HOST:=127.0.0.2
DB_PASSWORD:=4321
DB_DBNAME:=somedb
```

**Makefile**

```
include ./go_migrate.mk

CURRENT_DIR = $(shell pwd)

# You can override default variables from your own .env
ifneq (,$(wildcard ./.env))
	include .app.env
	export
endif
```
