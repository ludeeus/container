#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/debian.sh'\\033[0m"

CONTAINER_TYPE="$1"

apt-get update
apt-get install -y --no-install-recommends \
    nano \
    openssh-client \
    git \
    shellcheck

bash /include/install/ghcli-debian.sh
bash /include/install/container.sh "${CONTAINER_TYPE}"
bash /include/cleanup/debian.sh