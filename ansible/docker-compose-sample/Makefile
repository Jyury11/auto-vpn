.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: up
up: ## up
	@docker compose up -d --build

.PHONY: down
down: ## down
	@docker compose down

.PHONY: exec
exec: ## exec
	@docker compose exec master bash

.PHONY: execnode
execnode: ## exec
	@docker compose exec node1 bash

.PHONY: init
init: ## setpubkey
	@docker compose exec master bash /workspace/init.sh

.PHONY: setpubkey
setpubkey: ## setpubkey
	@docker compose exec node1 bash /workspace/sshkey.sh

.PHONY: check
check: ## check
	@docker compose exec master bash /workspace/check.sh
