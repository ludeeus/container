.DEFAULT_GOAL := help

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "ludeeus/container" "";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

init: requirements
	apt update
	apt install -y shellcheck

requirements:
	python3 -m pip install --upgrade setuptools wheel
	python3 -m pip install -r requirements.txt

documentation: ## Generate documentation
	python3 -m scripts.documentation

update: ## Update files
	python3 -m scripts.update

base-debian: ## Build base/debian
	@bash scripts/build.sh --container base/debian --test

base-debian-s6: ## Build base/debian-s6
	@bash scripts/build.sh --container base/debian-s6 --test

devcontainer-python: ## Build devcontainer/python
	@bash scripts/build.sh --container devcontainer/python --test

devcontainer-integration: ## Build devcontainer/integration
	@bash scripts/build.sh --container devcontainer/integration --test