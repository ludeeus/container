#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'container/alpine'\\033[0m"

apk update
apk add --no-cache \
    jq \
    make

bash /include/install/container/common.sh