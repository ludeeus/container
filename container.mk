.DEFAULT_GOAL := help
SHELL := /bin/bash

include /usr/share/container/makefiles/*.mk

help: ## Shows help message.
	@printf "\033[36m%s\n\n" "Welcome to this custom devcontainer!";
	@printf "\033[32m%s\n" "For the documentation for this devcontainer have a look here:";
	@printf "%s\n\n" "https://github.com/ludeeus/container";
	@printf "\033[0m\033[1m%s\033[0m\n" "Usage:";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m container %-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

.PHONY: start
run:
	@printf "\e[93m%s\e[0m\n" "'run' is deprecated, use 'start' instead"
	#start
