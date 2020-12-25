#!/usr/bin/env bash

echo -e "\\033[0;34mRunning cleanup script 'python.sh'\\033[0m"

find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \;

set -e
python --version
python3 --version