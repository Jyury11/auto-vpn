.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: up
up: ## up
	@docker compose up -d

.PHONY: down
down: ## down
	@docker compose down

.PHONY: exec
exec: ## exec
	@docker compose exec softether_bridge bash
