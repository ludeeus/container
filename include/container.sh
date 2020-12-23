#!/usr/bin/env bash

if [ ! -z "$(which apk)" ]; then
    apk add make
else
    apt update
    apt install -y make
fi

mkdir -p /opt/container/makefiles
mkdir -p /opt/container/helpers
touch /opt/container/makefiles/dummy.mk

mv /tmp/include/container.mk /opt/container/container.mk

mv /tmp/include/container /usr/bin/container
chmod +x /usr/bin/container

if [ -n "$1" ]; then
    if [ -f "/tmp/include/makefiles/$1.mk" ]; then
        cp "/tmp/include/makefiles/$1.mk" "/opt/container/makefiles/$1.mk"
    fi
    if [ -d "/tmp/include/helpers/$1" ]; then
        cp -r "/tmp/include/helpers/$1" "/opt/container/helpers/$1"
    fi
fi