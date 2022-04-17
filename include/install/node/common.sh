#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'node/common.sh'\\033[0m"
NODE_INSTALL_PATH="/usr/local/node"
NODE_VERSION=$(jq -r .node /include/install/node/versions.json)
YARN_INSTALL_PATH="/usr/local/yarn"
YARN_VERSION=$(jq -r .yarn /include/install/node/versions.json)

echo -e "\\033[0;34mInstalling NodeJS ${NODE_VERSION} to ${NODE_INSTALL_PATH}\\033[0m"

mkdir -p "${NODE_INSTALL_PATH}"
ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-armv7l.tar.xz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-arm64.tar.xz";
elif [ "$ARCH" == "x86_64" ]; then
    if [ -n "$(command -v apk)" ]; then
        wget -q -nv -O /tmp/nodejs.tar.xz "https://unofficial-builds.nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64-musl.tar.xz";
    else
        wget -q -nv -O /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz";
    fi
else
    echo "No target for $ARCH"
    exit 1
fi

tar -xJC "${NODE_INSTALL_PATH}" --strip-components=1 -f /tmp/nodejs.tar.xz

rm /tmp/nodejs.tar.xz
chown root:root -R "${NODE_INSTALL_PATH}"

wget -q -nv -O - https://yarnpkg.com/install.sh | bash -s -- --version "$YARN_VERSION"
mv "$HOME/.yarn" "${YARN_INSTALL_PATH}"

ls -la "${NODE_INSTALL_PATH}"/bin
ls -la "${YARN_INSTALL_PATH}"/bin

echo "NodeJS version:"
node --version

echo "NPM version:"
npm --version

echo "NPX version:"
npx --version

echo "Yarn version:"
yarn --version