include .env

deps:
	@echo "Installing dependencies..."
	@go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	@go mod tidy

lint:
	@echo "Linting..."
	@golangci-lint run --config .golangci.yaml

run:
	@echo "Starting and running the ETL..."
	./run.sh

migrateUp:
	@echo "Migrating up..."
	migrate -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB)?sslmode=disable" -verbose up

migrateDown:
	@echo "Migrating down..."
	migrate -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB)?sslmode=disable" -verbose down


.PHONY: deps lint run migrateUp migrateDown