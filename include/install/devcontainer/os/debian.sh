#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/os/debian.sh'\\033[0m"

apt-get update
apt-get install -y --no-install-recommends \
    nano \
    openssh-client \
    git \
    shellcheck

