FROM debian:10.3-slim

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    CONTAINER_TYPE="debian-base"

COPY rootfs/common /

RUN \
    apt update \
    \
    && apt install -y --no-install-recommends  \
        ca-certificates=20190110 \
        nano=3.2-3 \
        bash=5.0-4 \
        wget=1.20.1-1.1 \
        git=1:2.20.1-2+deb10u1 \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
    \
    && chmod +x /usr/bin/dc