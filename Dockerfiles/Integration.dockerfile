FROM ludeeus/devcontainer:base

ENV DEVCONTAINER_TYPE integration

COPY requirements.txt /tmp/

RUN \
    apk add --no-cache \
        gcc=8.3.0-r0 \
        libc-dev=0.7.1-r0 \
        libffi-dev=3.2.1-r6 \
        python3-dev=3.7.5-r1 \
        make=4.2.1-r2 \
        python3=3.7.5-r1 \
    \
    && mkdir -p /config/custom_components \
    \
    && pip3 install --no-cache-dir -U -r /tmp/requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && chmod +x /usr/bin/dc