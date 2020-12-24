#!/usr/bin/env bash
set -e

declare container
declare push
declare platforms
declare -a buildCommand=("buildx build . --compress")

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
            buildCommand+=(" --tag ghcr.io/ludeeus/$container:$2 ")
            shift
            ;;
        -l|--label)
            buildCommand+=(" --label $2 ")
            shift
            ;;
        -a|--arg)
            buildCommand+=(" --build-arg $2 ")
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
        buildCommand+=(" --tag $tag ")
    done
fi

if [ "$(jq -c -r .args "./containerfiles/$container/config.json")" != "null" ]; then
    for arg in $(jq -c -r '.args? |  to_entries[] | "\(.key)=\(.value)"' "./containerfiles/$container/config.json"); do
        buildCommand+=(" --build-arg $arg ")
    done
fi

if [ "$(jq -c -r -e .labels "./containerfiles/$container/config.json")" != "null" ]; then
    for label in $(jq -c -r '.labels? |  to_entries[] | "\(.key)=\(.value)"' "./containerfiles/$container/config.json"); do
        buildCommand+=(" --label $label ")
    done
fi

buildCommand+=("--platform "${platforms:-$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')}"")
buildCommand+=("--output=type=image,push="${push:-"false"}"")
buildCommand+=("--file ./containerfiles/$container/Dockerfile")
buildCommand+=("--label "org.opencontainers.image.documentation=https://github.com/ludeeus/container/tree/master/containerfiles/$container"")
buildCommand+=("--label "org.opencontainers.image.source=https://github.com/ludeeus/container"")
buildCommand+=("--label "org.opencontainers.image.created=$(date --utc +%FT%H:%M:%SZ)"")
echo "${buildCommand[@]}"

docker buildx create --name builder --use
docker buildx inspect --bootstrap

# shellcheck disable=SC2068
docker ${buildCommand[@]}
docker buildx rm builder