include .env

deps:
	@echo "Installing dependencies..."
	@go mod tidy

run:
	@echo "Starting and running the ETL..."
	./run.sh

.PHONY: deps run