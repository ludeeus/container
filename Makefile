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

