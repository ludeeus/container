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
echo "INSTALL COMPLETE"
update-ca-certificates
echo "UPDATE CA COMPLETE"
bash /include/cleanup/alpine.sh
echo "CLEANUP COMPLETE"
