# python-base-s6

[Back to overview](../index.md)

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:python-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python-base-s6
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.0.0.1)`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`ffmpeg-dev` | 4.3.1-r0
`gcc` | 9.3.0-r2
`git` | 2.26.2-r0
`libc-dev` | 0.7.2-r3
`libffi-dev` | 3.3-r2
`make` | 4.3-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`py3-pip` | 20.1.1-r0
`python3-dev` | 3.8.3-r0
`python3` | 3.8.3-r0

## Pyhton packages

Package | Version 
-- | --
`setuptools` | 49.2.0
`wheel` | 0.34.2



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV CONTAINER_TYPE=python-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        ffmpeg-dev=4.3.1-r0 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3-dev=3.8.3-r0 \ 
        python3=3.8.3-r0 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        setuptools==49.2.0 \ 
        wheel==0.34.2 \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-16T21:20:23.879259"
LABEL org.opencontainers.image.description="None"
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/python-base-s6"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="None"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Python-Base-S6"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/python-base-s6"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="None"
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
