#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/type/python.sh'\\033[0m"

bash /include/install/container.sh python

python3 -m pip --disable-pip-version-check install -U \
    pylint \
    black


ln -sf /usr/local/python/bin/python3 /usr/bin/python3
ln -sf /usr/local/python/bin/python3 /usr/bin/python
ln -sf /usr/local/python/bin/pip3 /usr/bin/pip
ln -sf /usr/local/python/bin/pip3 /usr/bin/pip3

bash /include/cleanup/python.sh