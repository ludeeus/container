#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/integration.sh'\\033[0m"

bash /include/install/devcontainer/python.sh

mkdir -p /config/custom_components