.DEFAULT_GOAL := help

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "ludeeus/container" "";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

init: requirements
	bash include

requirements: ## Install dev requirements
	python3 -m pip install --upgrade setuptools wheel
	python3 -m pip install -r requirements.txt

update-all: update-alpine update-debian update-ghcli update-node update-python update-s6 update-yarn ## Update all packages

update-alpine: ## Update Alpine
	python3 scripts/updates/alpine.py

update-debian: ## Update Debian
	python3 scripts/updates/debian.py

update-ghcli: ## Update GitHub-CLI
	python3 scripts/updates/ghcli.py

update-node: ## Update NodeJS
	python3 scripts/updates/node.py

update-python: ## Update Python
	python3 scripts/updates/python.py

update-s6: ## Update S6
	python3 scripts/updates/s6.py

update-yarn: ## Update Yarn
	python3 scripts/updates/yarn.py
