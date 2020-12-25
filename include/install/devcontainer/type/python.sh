#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/type/python.sh'\\033[0m"

bash /include/install/container.sh python

python3 -m pip --disable-pip-version-check install -U \
    pylint \
    black







bash /include/cleanup/python.sh