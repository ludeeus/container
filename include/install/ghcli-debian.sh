#!/usr/bin/env bash

echo -e "\033[0;34mRunning script 'ghcli-debian.sh'\033[0m"

apt-get update
apt-get install -y --no-install-recommends software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages
apt-get update
apt-get install -y gh
gh --help