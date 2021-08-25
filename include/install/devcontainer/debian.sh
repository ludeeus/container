#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/debian.sh'\\033[0m"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    libcap-dev \
    shellcheck \
    jq

wget -q -O - https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/common-debian.sh | bash -

apt-get purge -y python3
apt-get -y autoremove
