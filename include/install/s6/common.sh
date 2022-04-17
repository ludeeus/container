#!/usr/bin/env bash
# https://github.com/just-containers/s6-overlay
set -e
echo -e "\\033[0;34mRunning install script 's6/common'\\033[0m"
VERSION=$(jq -r .s6 /include/install/s6/versions.json)
ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/s6.tar.gz "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION}/s6-overlay-armhf.tar.gz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/s6.tar.gz "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION}/s6-overlay-aarch64.tar.gz";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/s6.tar.gz "https://github.com/just-containers/s6-overlay/releases/download/v${VERSION}/s6-overlay-amd64.tar.gz";
else
    echo "No target for $ARCH"
    exit 1
fi

tar xzf /tmp/s6.tar.gz -C /
rm /tmp/s6.tar.gz