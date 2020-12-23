#!/usr/bin/env bash
set -e

declare -a containerTags
declare -a containerLabels

container="$1"

if [ "$2" == "--push" ]; then
    push="true";
else
    push="false";
fi


for tag in $(jq -c -r .tags[] "./containerfiles/$container/config.json"); do
    containerTags+=(" --tag $tag ")
done

platforms=$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')

docker buildx create --name builder --use
docker buildx inspect --bootstrap

docker \
    buildx \
    build \
    --compress \
    --output=type=image,push="$push" \
    --file "./containerfiles/$container/Dockerfile" \
    --platform "$platforms" \
    . \
    ${containerTags[@]}


docker buildx rm builder