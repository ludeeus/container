#!/usr/bin/env bash
set -e
shopt -s extglob
declare container
declare push
declare test
declare platforms
declare -a buildCommand

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
            buildCommand+=(" --tag ghcr.io/ludeeus/${container//@(-debian|-alpine)}:$2 ")
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
        --test)
            test="true"
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

buildCommand+=("--output=type=image,push="${push:-"false"}"")
buildCommand+=("--file ./containerfiles/$container/Dockerfile")
buildCommand+=("--label "org.opencontainers.image.url=https://github.com/ludeeus/container/tree/master/containerfiles/$container"")
buildCommand+=("--label "org.opencontainers.image.documentation=https://github.com/ludeeus/container/tree/master/containerfiles/$container"")
buildCommand+=("--label "org.opencontainers.image.source=https://github.com/ludeeus/container"")
buildCommand+=("--label "org.opencontainers.image.title=$container"")
buildCommand+=("--label "org.opencontainers.image.ref.name=$(git rev-parse HEAD)"")
buildCommand+=("--label "org.opencontainers.image.created=$(date --utc +%FT%H:%M:%SZ)"")
echo "${buildCommand[@]}"

if [ "$test" != "true" ]; then
    buildCommand+=("--platform "${platforms:-$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')}"")
    docker buildx create --name builder --use
    docker buildx inspect --bootstrap
    # shellcheck disable=SC2068
    docker buildx build . --compress ${buildCommand[@]}
    docker buildx rm builder
else
    # shellcheck disable=SC2068
    docker build . --compress ${buildCommand[@]}
fi