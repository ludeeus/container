#!/usr/bin/env bash
set -e

declare container
declare push
declare platforms
declare -a containerTags
declare -a buildArgs
declare -a containerLabels

function error_handling() {
    docker buildx rm builder
}

trap 'error_handling' SIGINT SIGTERM

while [[ $# -gt 0 ]]; do
    key=$1
    case $key in
        -c|--container)
            container="$2"
            shift
            ;;
        -t|--tag)
            containerTags+=(" --tag ghcr.io/ludeeus/$container:$2 ")
            shift
            ;;
        -l|--label)
            containerLabels+=(" --label $2 ")
            shift
            ;;
        -a|--arg)
            buildArgs+=(" --build-arg $2 ")
            shift
            ;;
        --push)
            push="true"
            ;;
        -p|--platfroms)
            platforms="$2"
            shift
            ;;
        *)
            echo "Argument '$1' unknown" && exit 1
            ;;
    esac
    shift
done

if [ "$(jq -c -r .tags "./containerfiles/$container/config.json")" != "null" ]; then
    for tag in $(jq -c -r '.tags? | .[]' "./containerfiles/$container/config.json"); do
        containerTags+=(" --tag $tag ")
    done
fi

if [ "$(jq -c -r .args "./containerfiles/$container/config.json")" != "null" ]; then
    for arg in $(jq -c -r '.args? |  to_entries[] | "\(.key)=\(.value)"' "./containerfiles/$container/config.json"); do
        buildArgs+=(" --build-arg $arg ")
    done
fi

if [ "$(jq -c -r -e .labels "./containerfiles/$container/config.json")" != "null" ]; then
    for label in $(jq -c -r '.labels? |  to_entries[] | "\(.key)=\(.value)"' "./containerfiles/$container/config.json"); do
        containerLabels+=(" --label $label ")
    done
fi
echo ${buildArgs[@]}
platforms=$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')

docker buildx create --name builder --use
docker buildx inspect --bootstrap

docker \
    buildx \
    build \
    --compress \
    --output=type=image,push="${push:-"false"}" \
    --file "./containerfiles/$container/Dockerfile" \
    --platform "${platforms:-$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')}" \
    --label "org.opencontainers.image.source=https://github.com/ludeeus/container" \
    --label "org.opencontainers.image.created=$(date --utc +%FT%H:%M:%SZ)" \
    --label "org.opencontainers.image.documentation=https://github.com/ludeeus/container/tree/master/containerfiles/$container" \
    ${containerLabels[@]} \
    ${buildArgs[@]} \
    . \
    ${containerTags[@]}


docker buildx rm builder