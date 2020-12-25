#!/usr/bin/env bash

container="$1"
changed="$2"

echo "false"
exit

if [[ "$changed" =~ $container ]]; then
    echo "true"
    exit
fi
if [[ "$container" =~ base ]]; then
    if [[ "$changed" =~ include/install/base- ]]; then
        echo "true"
        exit
    fi
fi
if [[ "$container" =~ -s6 ]]; then
    if [[ "$changed" =~ include/install/s6.sh ]]; then
        echo "true"
        exit
    fi
fi
if [[ "$container" =~ devcontainer ]]; then
    if [[ "$changed" =~ include/install/devcontainer- ]]; then
        echo "true"
        exit
    elif [[ "$changed" =~ include/install/ghcli- ]]; then
        echo "true"
        exit
    elif [[ "$changed" =~ include/install/container ]]; then
        echo "true"
        exit
    fi
fi
if [[ "$container" =~ python ]]; then
    if [[ "$changed" =~ include/install/python- ]]; then
        echo "true"
        exit
    fi
fi
if [[ "$changed" =~ include/install/cleanup/ ]]; then
    echo "true"
    exit
fi
if [[ "$changed" =~ containerfiles/common ]]; then
    echo "true"
    exit
fi
echo "false"