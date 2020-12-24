#!/usr/bin/env bash

apt-get update
apt-get install -y --no-install-recommends apt-utils
apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    bash \
    wget \
    tar \
    unzip

bash /include/cleanup-debian.sh
