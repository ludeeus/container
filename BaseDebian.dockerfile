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
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
    \
    && chmod +x /usr/bin/dc