.DEFAULT_GOAL := help

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "HACS" "Integration";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

init: symlink requirements

requirements:
	python3 -m pip install --upgrade setuptools wheel
	python3 -m pip install -r requirements.txt

symlink:
	rm /usr/bin/container
	rm -r /usr/share/container
	ln -sf /workspaces/container/rootfs/common/etc/bash_completion.d/container_completion /etc/bash_completion.d/container_completion
	ln -sf /workspaces/container/rootfs/common/root/.bashrc /root/.bashrc
	ln -sf /workspaces/container/rootfs/common/usr/bin/container /usr/bin/container
	ln -sf /workspaces/container/rootfs/common/usr/share/container /usr/share/container

generate-documentation: ## Generate documentation
	python3 scripts/generate_documentation.py

build: ## Build containers
	python3 scripts/builder.py

update: ## Update files
	python3 scripts/update.py

test:
	python3 scripts/test.py
