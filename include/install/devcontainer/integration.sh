#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/integration.sh'\\033[0m"

bash /include/install/devcontainer/python.sh

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    ffmpeg \
    libjpeg-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libswresample-dev \
    zlib1g-dev


mkdir -p /config/custom_components

python3 -m pip --disable-pip-version-check install --upgrade \
    git+https://github.com/home-assistant/home-assistant.git@dev
python3 -m pip --disable-pip-version-check install --upgrade wheel setuptools

bash /include/cleanup/python.sh
