# python-debian

[Back to overview](../index.md)

_This provides a minimalistic container for working with python._

**Base image**: `debian:10.6-slim`  
**Full name**: `ludeeus/container:python-debian`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python-debian)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python-debian
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
- `make`
- `nano`
- `python3`
- `python3-dev`
- `python3-pip`
- `wget`

## Python packages

Package | Version 
-- | --
`black` | 20.8b1
`pylint` | 2.6.0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM debian:10.6-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=python-debian
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        gcc \ 
        libc-dev \ 
        libffi-dev \ 
        libavcodec-dev \ 
        python3-dev \ 
        make \ 
        python3 \ 
        python3-pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
        setuptools \ 
        wheel \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==20.8b1 \ 
        pylint==2.6.0 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
