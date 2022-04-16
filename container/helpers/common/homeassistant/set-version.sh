#!/usr/bin/env bash
# shellcheck source=/dev/null

source /opt/container/helpers/common/paths.sh

read -p 'Set Home Assistant version: ' -r version
python3 -m pip --disable-pip-version-check install --upgrade homeassistant=="$version"

if [[ -n "$(postSetVerionHook)" ]]; then
    "$(postSetVerionHook)" "$version"
fi