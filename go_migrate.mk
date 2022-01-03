ifeq (, $(shell which migrate))
 $(error "No go-migrate found in $(PATH). Install go-migrate before proceeding")
endif

MIGRATE_CMD=migrate
MIGRATE_CREATE_CMD=create
MIGRATE_UP_CMD=up
MIGRATE_DOWN_CMD=down

# Default posgres credentials.
DSN_PROTOCOL:=postgres
DB_USER:=postgres
DB_HOST:=127.0.0.1
DB_PORT:=5432
DB_PASSWORD:=1234
DB_NAME:=sample

CURRENT_DIR = $(shell pwd)
MIGRATION_DIR = $(CURRENT_DIR)/db/migrations

DB_DSN=$(DSN_PROTOCOL)://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable

migrate_create:
	$(MIGRATE_CMD) $(MIGRATE_CREATE_CMD) -ext sql -dir $(MIGRATION_DIR) -seq $(filter-out $@, $(MAKECMDGOALS))

migrate_up:
	$(MIGRATE_CMD) -path=$(MIGRATION_DIR) -database $(DB_DSN) $(MIGRATE_UP_CMD)

migrate_down:
	$(MIGRATE_CMD) -path=$(MIGRATION_DIR) -database $(DB_DSN) $(MIGRATE_DOWN_CMD) $(filter-out $@, $(MAKECMDGOALS))
