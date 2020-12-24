#!/usr/bin/env bash
set -e

declare -a containerTags
declare -a containerLabels

CONTAINER=${1:-"devcontainer/python"}
PUSH=${2:-"false"}

for tag in $(jq -c -r .tags[] "./containerfiles/$CONTAINER/config.json"); do
    containerTags+=(" --tag $tag ")
done

platforms=$(jq -r -c '.platforms | @csv' "./containerfiles/$CONTAINER/config.json" | tr -d '"')

docker buildx create --name builder --use
docker buildx inspect --bootstrap

docker \
    buildx \
    build \
    --compress \
    --output=type=image,push="$PUSH" \
    --file "./containerfiles/$CONTAINER/Dockerfile" \
    --platform "$platforms" \
    --label "org.opencontainers.image.source=https://github.com/ludeeus/container" \
    --label "org.opencontainers.image.created=$(date --utc +%FT%H:%M:%SZ)" \
    --label "org.opencontainers.image.documentation=https://github.com/ludeeus/container/tree/master/containerfiles/$CONTAINER" \
    . \
    ${containerTags[@]}


docker buildx rm builder