#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 's6/debian'\\033[0m"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install --no-install-recommends \
    jq

bash /include/install/s6/common.sh