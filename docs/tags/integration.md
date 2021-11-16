# integration

[Back to overview](../index.md)

_This provides a minimalistic container for working with python._

**Base image**: `alpine:3.14.3`  
**Full name**: `ludeeus/container:integration`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=integration)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | integration
`DEVCONTAINER` | True

## Features

- `devcontainer`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`ffmpeg-dev` | 4.4.1-r0
`gcc` | 10.3.1_git20210424-r2
`git` | 2.32.0-r0
`jpeg-dev` | 9d-r1
`libc-dev` | 0.7.2-r3
`libffi-dev` | 3.3-r2
`make` | 4.3-r0
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0
`py3-pip` | 20.3.4-r1
`python3-dev` | 3.9.5-r1
`python3` | 3.9.5-r1
`zlib-dev` | 1.2.11-r3

## Python packages

Package | Version 
-- | --
`black` | 21.10b0
`pylint` | 2.11.1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.3

ENV CONTAINER_TYPE=integration
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        ffmpeg-dev=4.4.1-r0 \ 
        gcc=10.3.1_git20210424-r2 \ 
        git=2.32.0-r0 \ 
        jpeg-dev=9d-r1 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
        py3-pip=20.3.4-r1 \ 
        python3-dev=3.9.5-r1 \ 
        python3=3.9.5-r1 \ 
        zlib-dev=1.2.11-r3 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
        setuptools \ 
        wheel \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==21.10b0 \ 
        pylint==2.11.1 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && mkdir -p /config/custom_components \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
