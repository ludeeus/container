#!/usr/bin/env bash
set -e

declare -a dockerTags
declare -a platforms

container="$1"

if [ "$2" == "--push" ]; then
    runType="--push";
else
    runType="--load";
fi


config=$(jq . -r ./containerfiles/$container/config.json)

for tag in $(cat ./containerfiles/$container/config.json | jq -c -r .tags[]); do
    dockerTags+=(" --tag $tag ")
done

platforms=$(cat ./containerfiles/$container/config.json | jq -r -c '.platforms | @csv' | tr -d '"')

docker buildx create --name builder --use
docker buildx inspect --bootstrap

docker \
    buildx \
    build \
    --compress \
    "$runType" \
    --file "./containerfiles/$container/Dockerfile" \
    --platform "$platforms" \
    . \
    ${dockerTags[@]}


docker buildx rm builder