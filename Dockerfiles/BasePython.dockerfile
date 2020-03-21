FROM ludeeus/container:base

ENV CONTAINER_TYPE python

COPY requirements.txt /tmp/

RUN \
    apk add --no-cache \
        gcc=9.2.0-r4 \
        libc-dev=0.7.2-r0 \
        libffi-dev=3.2.1-r6 \
        ffmpeg-dev=4.2.1-r3 \
        python3-dev=3.8.2-r0 \
        make=4.2.1-r2 \
        python3=3.8.2-r0 \
    \
    && rm -rf /var/cache/apk/* \
    \
    && pip3 install --no-cache-dir -U -r /tmp/requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \