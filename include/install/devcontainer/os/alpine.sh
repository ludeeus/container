#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/os/alpine.sh'\\033[0m"

apk update
apk add --no-cache \
    jq