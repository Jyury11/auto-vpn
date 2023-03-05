PROJECT = $(shell gcloud config get-value project)
TFVARS := terraform.tfvars

.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: ## init
	@terraform init -upgrade
	@make tfvars

.PHONY: plan
plan: $(TFVARS) ## plan
	@terraform plan -var-file terraform.tfvars

.PHONY: apply
apply: $(TFVARS) ## apply
	@terraform apply -var-file terraform.tfvars

.PHONY: tfvars
tfvars: ## tfvars
	@bash gen-tfvars.sh $(PROJECT)

$(TFVARS): ## tfvars
	@bash gen-tfvars.sh $(PROJECT)
