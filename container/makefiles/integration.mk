start:  ## Start Home Assistant with the integration loaded
	@bash /opt/container/helpers/integration/start.sh

install:  ## Install Home Assistant dev in the container
	python3 -m pip --disable-pip-version-check install --upgrade git+git://github.com/home-assistant/home-assistant.git@dev