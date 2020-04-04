FROM alpine:3.11.5

ENV \
    CONTAINER_TYPE="alpine-base"

COPY rootfs/common /

RUN \
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && apk add --no-cache \
        openssl-dev=1.1.1d-r3 \
        nano=4.6-r0 \
        openssh=8.1_p1-r0 \
        bash=5.0.11-r1 \
        git=2.24.1-r0 \
        curl=7.67.0-r0 \
    \
    && rm -rf /var/cache/apk/* \
    \
    && chmod +x /usr/bin/dc