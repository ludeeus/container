#!/usr/bin/env bash
CONTAINER_TYPE="$1"

apt-get update
apt-get install -y --no-install-recommends \
    nano \
    openssh-client \
    git

bash /include/install/ghcli-debian.sh
bash /include/install/container.sh "${CONTAINER_TYPE}"
bash /include/cleanup-debian.sh