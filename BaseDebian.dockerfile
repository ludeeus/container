FROM debian:10.3-slim

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    DEVCONTAINER_TYPE="base-debian"

WORKDIR /workspace

COPY rootfs /

RUN \
    apt update \
    \
    && apt install -y --no-install-recommends  \
        ca-certificates \
        nano \
        bash \
        wget \
        git \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
    \
    && chmod +x /usr/bin/dc