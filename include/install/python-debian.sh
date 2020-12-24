#!/usr/bin/env bash

apt-get update
apt-get install -y --no-install-recommends wget

PYTHON_VERSION="$1"
PYTHON_INSTALL_PATH="${2:-"/usr/local/python${PYTHON_VERSION}"}"
export PIPX_HOME="${3:-"/usr/local/py-utils"}"

echo "Installing Python ${PYTHON_VERSION}"

wget -q -O /tmp/install_python.sh https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/python-debian.sh
bash /tmp/install_python.sh "${PYTHON_VERSION}" "${PYTHON_PATH}" "${PIPX_HOME}"
rm /tmp/install_python.sh

python --version