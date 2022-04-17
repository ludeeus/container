#!/usr/bin/env bash
set -e
shopt -s extglob
declare container
declare push
declare test
declare tagPrefix="ghcr.io/ludeeus"
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
        --title)
            buildCommand+=(" --label org.opencontainers.image.title=\"$2\" ")
            shift
            ;;
        -t|--tag)
            buildCommand+=(" --tag ${tagPrefix}/${container}:$2 ")
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
        --tag-prefix)
            tagPrefix="$2"
            shift
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
        buildCommand+=(" --tag ${tagPrefix}/${container}:$tag ")
    done
else
    buildCommand+=(" --tag ghcr.io/ludeeus/${container//@(-debian|-alpine)}:latest ")
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

if [ "$(jq -c -r .dockerfile "./containerfiles/$container/config.json")" != "null" ]; then
    buildCommand+=("--file ./containerfiles/$(jq -c -r .dockerfile "./containerfiles/$container/config.json")")
else
    buildCommand+=("--file ./containerfiles/$container/Containerfile")
fi

buildCommand+=("--output=type=image,push=${push:-false}")
buildCommand+=("--label org.opencontainers.image.url=https://github.com/ludeeus/container/tree/main/containerfiles/$container")
buildCommand+=("--label org.opencontainers.image.documentation=https://github.com/ludeeus/container/tree/main/containerfiles/$container")
buildCommand+=("--label org.opencontainers.image.source=https://github.com/ludeeus/container")
buildCommand+=("--label org.opencontainers.image.ref.name=$(git rev-parse HEAD)")
buildCommand+=("--label org.opencontainers.image.created=$(date --utc +%FT%H:%M:%SZ)")
echo "${buildCommand[@]}"

if [ "$test" != "true" ]; then
    # shellcheck disable=SC2145,SC2046
    echo "docker build . --compress ${buildCommand[@]} --label "org.opencontainers.image.description=\"$(jq -c -r .description ./containerfiles/"$container"/config.json)\"""
    buildCommand+=("--platform ${platforms:-$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')}")
    set +e
    docker buildx rm builder
    set -e
    docker buildx create --name builder --use
    docker buildx inspect --bootstrap
    # shellcheck disable=SC2068
    docker buildx build . --compress ${buildCommand[@]} --label "org.opencontainers.image.description=\"$(jq -c -r .description ./containerfiles/"$container"/config.json)\""
    docker buildx rm builder
else
    # shellcheck disable=SC2145
    echo "docker build . --compress ${buildCommand[@]}"
    # shellcheck disable=SC2068
    docker build . --compress ${buildCommand[@]}
fi