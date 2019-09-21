FROM alpine:3.10

ENV DEVCONTAINER True
ENV DEVCONTAINER_TYPE base

WORKDIR /workspace

COPY rootfs /

RUN \
    apk add --no-cache \
        openssl-dev=1.1.1d-r0 \
        nano=4.3-r0 \
        openssh=8.0_p1-r0 \
        bash=5.0.0-r0 \
        git=2.22.0-r0 \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && chmod +x /usr/bin/dc