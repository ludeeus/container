
init: ## Initialize with custom-cards/boilerplate
	source /workspaces/container/rootfs/common/usr/share/container/tools
	git clone https://github.com/custom-cards/boilerplate-card.git /tmp/init
	rm -R /tmp/init/.git
	rm -R /tmp/init/.devcontainer
	cp -a /tmp/init/. $$(find /workspaces -mindepth 1 -maxdepth 1 -type d)