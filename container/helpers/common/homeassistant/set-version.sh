#!/usr/bin/env bash

read -p 'Set Home Assistant version: ' version
python3 -m pip --disable-pip-version-check install --upgrade homeassistant=="$version"