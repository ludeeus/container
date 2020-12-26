#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'python/alpine.sh'\\033[0m"
PYTHON_VERSION="$1"

apk update
apk add  --no-cache \
    jq

apk add --no-cache --virtual .fetch-deps \
    openssl \
    tar \
    curl \
    xz

apk add --no-cache --virtual .build-deps  \
    bluez-dev \
    build-base \
    bzip2-dev \
    coreutils \
    dpkg-dev dpkg \
    expat-dev \
    findutils \
    gdbm-dev \
    libc-dev \
    libffi-dev \
    libnsl-dev \
    libtirpc-dev \
    linux-headers \
    make \
    ncurses-dev \
    openssl \
    openssl-dev \
    patch \
    pax-utils \
    readline-dev \
    sqlite-dev \
    tcl-dev \
    tk \
    tk-dev \
    xz-dev \
    zlib-dev


bash /include/install/python/common.sh "$PYTHON_VERSION"