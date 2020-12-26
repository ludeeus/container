#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'container/debian'\\033[0m"
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    jq \
    make

bash /include/install/container/common.sh