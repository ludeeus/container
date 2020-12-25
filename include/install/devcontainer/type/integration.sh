#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/type/integration.sh'\\033[0m"

bash /include/install/devcontainer/type/python.sh
bash /include/install/container.sh integration


mkdir -p /config/custom_components