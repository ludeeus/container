FROM bitnami/minideb:buster

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    DEVCONTAINER_TYPE="base-debian"

WORKDIR /workspace

COPY rootfs /

RUN \
    install_packages \
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