#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'container.sh'\\033[0m"

if [ -n "$(command -v apk)" ]; then
    apk add make
else
    apt-get update
    apt-get install -y --no-install-recommends make
fi

mkdir -p /opt/container/makefiles
mkdir -p /opt/container/helpers
touch /opt/container/makefiles/dummy.mk

mv /container/container.mk /opt/container/container.mk
cp -r /container/helpers/common /opt/container/helpers/common

mv /container/container /usr/bin/container
chmod +x /usr/bin/container

if [ -n "$1" ]; then
    if [ -f "/container/makefiles/$1.mk" ]; then
        cp "/container/makefiles/$1.mk" "/opt/container/makefiles/$1.mk"
    fi
    if [ -d "/container/helpers/$1" ]; then
        cp -r "/container/helpers/$1" "/opt/container/helpers/$1"
    fi
fi

container help