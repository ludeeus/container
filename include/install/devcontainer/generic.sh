#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'devcontainer/generic.sh'\\033[0m"

bash "/include/install/node/$1.sh"
