#!/usr/bin/env bash

container="$1"
changed="$2"

function shouldBuild () { echo "true" && exit;}

if [[ "$changed" =~ $container ]]; then shouldBuild; fi
if [[ "$changed" =~ include/cleanup ]]; then shouldBuild; fi

if [[ "$container" =~ base/os ]]; then
    if [[ "$changed" =~ base/Os.dockerfile ]]; then shouldBuild; fi

    if [[ "$container" =~ alpine ]]; then
        if [[ "$changed" =~ include/install/base/alpine.sh ]]; then shouldBuild; fi
    elif [[ "$container" =~ debian ]]; then
        if [[ "$changed" =~ include/install/base/debian.sh ]]; then shouldBuild; fi
    fi
fi

if [[ "$container" =~ base/runtime ]]; then
    if [[ "$changed" =~ base/os ]]; then shouldBuild; fi
    if [[ "$changed" =~ base/Runtime.dockerfile ]]; then shouldBuild; fi
    if [[ "$container" =~ python ]]; then
        if [[ "$changed" =~ include/install/python/common.sh ]]; then shouldBuild; fi
        if [[ "$container" =~ alpine ]]; then
            if [[ "$changed" =~ include/install/python/alpine.sh ]]; then shouldBuild; fi
        elif [[ "$container" =~ debian ]]; then
            if [[ "$changed" =~ include/install/python/debian.sh ]]; then shouldBuild; fi
        fi
    fi
fi


if [[ "$container" =~ -s6 ]]; then
    if [[ "$changed" =~ base/os ]]; then shouldBuild; fi
    if [[ "$changed" =~ base/runtime ]]; then shouldBuild; fi
    if [[ "$changed" =~ s6.dockerfile ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/s6.sh ]]; then shouldBuild; fi
fi


if [[ "$container" =~ devcontainer ]]; then
    if [[ "$changed" =~ base/os ]]; then shouldBuild; fi
    if [[ "$changed" =~ base/runtime ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/devcontainer ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/container.sh ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/ghcli.sh ]]; then shouldBuild; fi
fi


echo "false"