.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init:
	@bash scripts/init.sh

.PHONY: terraform-init
terraform-init:
	@cd terraform/state && make init

.PHONY: terraform-create-state-bucket
terraform-create-state-bucket:
	@cd terraform/state && make apply
	@cd terraform && make init

.PHONY: terraform-create-vm
terraform-create-vm:
	@cd terraform && make apply

.PHONY: setup-ssh
setup-ssh:
	@bash scripts/setup-ssh.sh

.PHONY: ssh
ssh:
	@ssh -F ansible/cloud/.ssh/config vpnserver

.PHONY: install
install:
	@cd ansible/cloud && make install

.PHONY: bridge
bridge:
	@cd local/vpnbridge && make up
