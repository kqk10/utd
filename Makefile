.PHONY: format up restart exec logs down

COMPOSE_FILE := compose.yaml
COMPOSE_CMD := docker compose -f $(COMPOSE_FILE)

format:
	@yq -i 'sort_keys(..)' $(COMPOSE_FILE)
	@yq -i '.services.cdh5.extra_hosts |= sort' $(COMPOSE_FILE)
	@yq -i '.services.cdh5.ports |= sort' $(COMPOSE_FILE)
	@yq -i '.services.cdh5.tmpfs |= sort' $(COMPOSE_FILE)

up: format
	@$(COMPOSE_CMD) up -d --build

restart: format
	@$(COMPOSE_CMD) restart cdh5

setup: format
	@./scripts/setup.sh

exec: format
	@$(COMPOSE_CMD) exec cdh5 bash

logs: format
	@$(COMPOSE_CMD) logs cdh5

down: format
	@$(COMPOSE_CMD) down
