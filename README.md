## Why?

I use [go-migrate](https://github.com/golang-migrate/migrate) across different projects. I found myself repeatedly copy paste these commands everytime I created a new go project. I thought it might be a good idea to extract those commands out to better maintain it.


## Environment variables

`go-migrate-makefile` uses following environment variables as setup to run `go-migrate` commands. Following are list of default env vars.

```
DSN_PROTOCOL:=postgres
DB_USER:=postgres
DB_HOST:=127.0.0.1
DB_PASSWORD:=1234
DB_DBNAME:=sample
DB_DSN:=$(DSN_PROTOCOL)://$(PG_USER):$(PG_PASSWORD)@$(PG_HOST):$(PG_PORT)/$(PG_DBNAME)?sslmode=disable
```

You can override it to suite your need:

**.env**

```
DB_USER:=postgres
DB_HOST:=127.0.0.2
DB_PASSWORD:=4321
DB_DBNAME:=somedb

```

**Makfile**

```
# Include go_migrate_makefile
include ./go_migrate_makefile

CURRENT_DIR = $(shell pwd)

# You can override default variables from your own .env
ifneq (,$(wildcard ./.env))
	include .app.env
	export
endif

```


## Include it in yor Makefile

You can include these commands to your `Makefile` like:

```
include ./go_migrate_makefile
```

If you want make to simply ignore a makefile which does not exist or cannot be remade, with no error message, use the -include directive instead of include, like this:

```
-include ./go_migrate_makefile
```

