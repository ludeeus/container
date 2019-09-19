FROM alpine:3.10

ENV DEVCONTAINER True
ENV SHELL /bin/bash

WORKDIR /workspace

COPY rootfs /
COPY requirements.txt /tmp/

RUN \
    apk add --no-cache\
        gcc=8.3.0-r0 \
        libc-dev=0.7.1-r0 \
        libffi-dev=3.2.1-r6 \
        openssl-dev=1.1.1d-r0 \
        python3-dev=3.7.3-r0 \
        bash=5.0.0-r0 \
        git=2.22.0-r0 \
        python3=3.7.3-r0 \
    \
    && mkdir -p /config/custom_components \
    && mkdir -p /config/www \
    \
    && pip3 install --no-cache-dir -U -r /tmp/requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && chmod +x /usr/bin/dc