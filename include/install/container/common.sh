#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'container/common'\\033[0m"
mkdir -p /opt/container/makefiles
mkdir -p /opt/container/helpers
touch /opt/container/makefiles/dummy.mk

cp /container/container.mk /opt/container/container.mk
cp -r /container/helpers/common /opt/container/helpers/common

cp /container/container /usr/bin/container
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