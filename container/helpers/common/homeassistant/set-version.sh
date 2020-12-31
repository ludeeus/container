#!/usr/bin/env bash

read -p -r 'Set Home Assistant version: ' version
python3 -m pip --disable-pip-version-check install --upgrade homeassistant=="$version"