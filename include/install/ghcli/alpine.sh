#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'ghcli/alpine'\\033[0m"

apk update
apk add  --no-cache \
    jq \
    libc6-compat

bash /include/install/ghcli/common.sh