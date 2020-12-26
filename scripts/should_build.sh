#!/usr/bin/env bash

container="$1"
changed="$2"

containeros=${container%%/*}
containername=${container#*/}

function shouldBuild () { echo "true" && exit;}

shouldBuild

if [[ "$changed" =~ $container ]]; then shouldBuild; fi
if [[ "$changed" =~ Os.containerfile ]]; then shouldBuild; fi

if [[ "$container" =~ $containeros/ ]]; then
    if [[ "$changed" =~ $containeros/base ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/$containername ]]; then shouldBuild; fi
fi

if [[ "$container" =~ -s6 ]]; then
    if [[ "$changed" =~ $containeros/base ]]; then shouldBuild; fi
    if [[ "$changed" =~ $containeros/$containername ]]; then shouldBuild; fi
    if [[ "$changed" =~ S6.containerfile ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install/s6 ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install ]]; then shouldBuild; fi
fi


if [[ "$container" =~ devcontainer ]]; then
    if [[ "$changed" =~ debian/base ]]; then shouldBuild; fi
    if [[ "$changed" =~ debian/$containername ]]; then shouldBuild; fi
    if [[ "$changed" =~ include/install ]]; then shouldBuild; fi
    if [[ "$changed" =~ container/ ]]; then shouldBuild; fi
fi


echo "false"