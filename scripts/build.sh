#!/usr/bin/env bash
set -e

declare -a dockerTags
declare -a platforms

container="$1"

if [ "$2" == "--push" ]; then
    push="true";
else
    push="false";
fi


for tag in $(jq -c -r .tags[] "./containerfiles/$container/config.json"); do
    dockerTags+=(" --tag $tag ")
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
    ${dockerTags[@]}


docker buildx rm builder