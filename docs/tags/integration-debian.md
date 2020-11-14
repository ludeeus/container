# integration-debian

[Back to overview](../index.md)

_This provides a minimalistic container for working with python._

**Base image**: `python:3.9-slim-buster`  
**Full name**: `ludeeus/container:integration-debian`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=integration-debian)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | integration-debian
`DEBIAN_FRONTEND` | noninteractive
`DEVCONTAINER` | True

## Features

- `devcontainer`

## Debian packages

- `bash`
- `ca-certificates`
- `gcc`
- `git`
- `libavcodec-dev`
- `libc-dev`
- `libffi-dev`
- `libjpeg-dev`
- `make`
- `nano`
- `python3`
- `python3-dev`
- `python3-pip`
- `wget`
- `zlib1g-dev`

## Python packages

Package | Version 
-- | --
`black` | 20.8b1
`colorlog` | 4.6.2
`pylint` | 2.6.0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM python:3.9-slim-buster

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=integration-debian
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        bash \ 
        ca-certificates \ 
        gcc \ 
        git \ 
        libavcodec-dev \ 
        libc-dev \ 
        libffi-dev \ 
        make \ 
        nano \ 
        python3-dev \ 
        python3-pip \ 
        python3 \ 
        wget \ 
        libjpeg-dev \ 
        zlib1g-dev \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
        setuptools \ 
        wheel \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==20.8b1 \ 
        colorlog==4.6.2 \ 
        pylint==2.6.0 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && mkdir -p /config/custom_components \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
