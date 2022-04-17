.DEFAULT_GOAL := help

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "ludeeus/container" "";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

init: requirements

requirements:
	python3 -m pip install --upgrade setuptools wheel
	python3 -m pip install -r requirements.txt

update:
	python3 scripts/updates/alpine.py
	python3 scripts/updates/debian.py
	python3 scripts/updates/ghcli.py
	python3 scripts/updates/github.py
	python3 scripts/updates/node.py
	python3 scripts/updates/python.py
	python3 scripts/updates/s6.py
	python3 scripts/updates/yarn.py