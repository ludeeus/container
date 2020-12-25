#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'ghcli'\\033[0m"

CLI_VERSION="1.4.0"
ARCH=$(uname -m)

if [ -n "$(command -v apk)" ]; then
    apk add libc6-compat
fi

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${CLI_VERSION}/gh_${CLI_VERSION}_linux_armv6.tar.gz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${CLI_VERSION}/gh_${CLI_VERSION}_linux_arm64.tar.gz";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/ghcli.tar.gz "https://github.com/cli/cli/releases/download/v${CLI_VERSION}/gh_${CLI_VERSION}_linux_amd64.tar.gz";
fi

mkdir -p /tmp/ghcli
tar xzf /tmp/ghcli.tar.gz -C /tmp/ghcli
mv /tmp/ghcli/*/bin/gh /usr/bin
rm -rf /tmp/ghcli.tar.gz /tmp/ghcli

set -e
gh --version
set +e