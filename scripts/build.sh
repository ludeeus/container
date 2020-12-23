#!/usr/bin/env bash

declare -a dockerTags
declare -a platforms

dockerfile="$1"

if [ "$2" == "--push" ]; then
    runType="--push";
else
    runType="--load";
fi


config=$(jq . -r ./containerfiles/$dockerfile/config.json)

for tag in $(cat ./containerfiles/$dockerfile/config.json | jq -c -r .tags[]); do
    dockerTags+=(" --tag $tag ")
done

platforms=$(cat ./containerfiles/$dockerfile/config.json | jq -r -c '.platforms | @csv' | tr -d '"')

docker buildx create --name builder
docker buildx use builder
docker buildx inspect --bootstrap

docker \
    buildx \
    build \
    --compress \
    "$runType" \
    --file "./containerfiles/$dockerfile/Dockerfile" \
    --platform "$platforms" \
    . \
    ${dockerTags[@]}


docker buildx rm builder