start:  ## Start Home Assistant
	@bash /opt/container/helpers/common/start.sh

install:  ## Install Home Assistant dev in the container
	python3 -m pip --disable-pip-version-check install --upgrade git+git://github.com/home-assistant/home-assistant.git@dev