#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'node/debian.sh'\\033[0m"
NODE_VERSION="$1"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install --no-install-recommends \
    tar \
    jq \
    xz-utils

bash /include/install/node/common.sh "$NODE_VERSION"
bash /include/cleanup/debian.sh