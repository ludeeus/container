FROM alpine:3.11

ENV \
    DEVCONTAINER_TYPE="base"

WORKDIR /workspace

COPY rootfs /

RUN \
    apk add --no-cache \
        openssl-dev=1.1.1d-r3 \
        nano=4.6-r0 \
        openssh=8.1_p1-r0 \
        bash=5.0.11-r1 \
        git=2.24.1-r0 \
        go=1.13.4-r1 \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && chmod +x /usr/bin/dc