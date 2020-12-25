#!/usr/bin/env bash

echo -e "\033[0;34mRunning install script 'python-debian.sh'\033[0m"

PYTHON_VERSION="$1"
export DEBIAN_FRONTEND=noninteractive

apt-get update


