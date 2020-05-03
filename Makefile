SHELL:=/bin/bash

.DEFAULT_GOAL:=help

# Commands to be shown when running "make help".
.PHONY: help install start prune

help:  ## Displays this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## Build the environment.
	$(info Building the environment...)
	@chmod 777 ./docker/entrypoint.sh && \
		docker-compose build

start: ## Starts the server with Docker, exposing the web in "http://localhost:4000".
	$(info Starting server...)
	@docker-compose up

prune: ## Deletes all Docker's containers, networks, volumes, images and cache.
	$(info Removing all Docker related info...)
	@docker system prune -af --volumes --filter label=bloenix

test: ## Starts the test runner.
	$(info Running tests...)
	@docker-compose exec web mix test
