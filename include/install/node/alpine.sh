#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'node/alpine.sh'\\033[0m"

apk update
apk add --no-cache \
    libstdc++ \
    jq \
    curl

bash /include/install/node/common.sh