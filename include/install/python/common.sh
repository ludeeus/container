#!/usr/bin/env bash

echo -e "\033[0;34mRunning install script 'python-common.sh'\033[0m"

PYTHON_VERSION="$1"

PYTHON_PATH=/usr/local/python
export PYTHON_INSTALL_PATH="/usr/local/python${PYTHON_VERSION}"
export PIPX_HOME="/usr/local/py-utils"
export PIPX_BIN_DIR=/usr/local/py-utils/bin
export PATH=${PYTHON_PATH}/bin:${PATH}:${PIPX_BIN_DIR}

echo "Installing Python ${PYTHON_VERSION}"


bash /include/cleanup/python.sh
python --version
