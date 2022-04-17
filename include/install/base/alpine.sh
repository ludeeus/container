#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'base/alpine.sh'\\033[0m"

apk update
apk add --no-cache \
    jq \
    ca-certificates \
    openssl \
    openssh \
    bash \
    wget \
    git

update-ca-certificates
bash /include/cleanup/alpine.sh
