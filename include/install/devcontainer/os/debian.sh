#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'devcontainer/os/debian.sh'\\033[0m"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends shellcheck

wget -q -O - https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/common-debian.sh | bash -

