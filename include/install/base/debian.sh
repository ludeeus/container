#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'base/debian.sh'\\033[0m"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends apt-utils
apt-get install -y --no-install-recommends \
    jq \
    apt-transport-https \
    ca-certificates \
    curl \
    bash \
    wget \
    tar \
    unzip

bash /include/cleanup/debian.sh
