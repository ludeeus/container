#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/integration.sh'\\033[0m"

bash /include/install/devcontainer/python.sh

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    libjpeg-dev \
    zlib1g-dev


mkdir -p /config/custom_components

python3 -m pip --disable-pip-version-check install --upgrade \
    git+https://github.com/home-assistant/home-assistant.git@dev

bash /include/cleanup/python.sh