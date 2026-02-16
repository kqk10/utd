.PHONY: clean format up restart exec logs down

COMPOSE_FILE := compose.yaml
COMPOSE_CMD := docker compose -f $(COMPOSE_FILE)

clean:
	@rm -rf ./data && mkdir -p ./data

format: clean
	@yq -i 'sort_keys(..)' $(COMPOSE_FILE)

up: format
	@$(COMPOSE_CMD) up -d --build

restart: format
	@$(COMPOSE_CMD) restart cdh5

exec: format
	@$(COMPOSE_CMD) exec cdh5 bash

logs: format
	@$(COMPOSE_CMD) logs cdh5

down: format
	@$(COMPOSE_CMD) down
