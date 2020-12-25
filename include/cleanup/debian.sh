#!/usr/bin/env bash

echo -e "\033[0;34mRunning cleanup script 'debian.sh'\033[0m"

apt-get clean -y
rm -fr /var/lib/apt/lists/*
rm -fr /tmp/* /var/{cache,log}/*