#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'ghcli/common'\\033[0m"
VERSION=$(jq -r .ghcli /include/install/ghcli/versions.json)
ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_armv6.tar.gz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_arm64.tar.gz";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz";
fi

mkdir -p /tmp/ghcli
tar xzf /tmp/ghcli.tar.gz -C /tmp/ghcli
mv /tmp/ghcli/*/bin/gh /usr/bin
rm -rf /tmp/ghcli.tar.gz /tmp/ghcli

set -e
gh --version