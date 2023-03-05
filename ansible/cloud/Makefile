VARS := ./playbook/node/roles/docker/files/docker-compose.yml \
	./playbook/accounts.yml

.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup:  ## setup
	@python scripts/init.py
	@ansible-playbook playbook/master/setup.yml
	@ansible-playbook playbook/master/user.yml

.PHONY: install
install:  ## setup
	@ansible-playbook -i hosts/hosts.yaml playbook/node/playbook.yml

$(VARS):  ## create variables
	@bash scripts/create-variables.sh $(USER) $(PASSWORD) $(SECRET)

.PHONY: var
var:  ## create variables
	@bash scripts/create-variables.sh $(USER) $(PASSWORD) $(SECRET)
