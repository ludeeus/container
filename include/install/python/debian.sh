#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'python/debian.sh'\\033[0m"

PYTHON_VERSION="$1"
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    make \
    build-essential \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    jq \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    liblzma-dev

bash /include/install/python/common.sh "$PYTHON_VERSION"
bash /include/cleanup/debian.sh