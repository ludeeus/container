#!/usr/bin/env bash
set -e
shopt -s extglob
declare container
declare push
declare title
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
            title="$2"
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

echo "${buildCommand[@]}"

# shellcheck disable=SC2068,SC2086
docker buildx build . \
    --output=type=image,push="${push:-false}" \
    --platform ${platforms:-$(jq -r -c '.platforms | @csv' "./containerfiles/$container/config.json" | tr -d '"')} \
    --compress ${buildCommand[@]} \
    --label org.opencontainers.image.url="https://github.com/ludeeus/container/tree/main/containerfiles/$container" \
    --label org.opencontainers.image.documentation="https://github.com/ludeeus/container/tree/main/containerfiles/$container" \
    --label org.opencontainers.image.source="https://github.com/ludeeus/container" \
    --label org.opencontainers.image.ref.name="$(git rev-parse HEAD)" \
    --label org.opencontainers.image.created="$(date --utc +%FT%H:%M:%SZ)" \
    --label org.opencontainers.image.title="$title" \
    --label "org.opencontainers.image.description=\"$(jq -c -r .description ./containerfiles/"$container"/config.json)\""
