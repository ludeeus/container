# python-base-debian

[Back to overview](../index.md)

**Base image**: `python:3.9-slim-buster`  
**Full name**: `ludeeus/container:python-base-debian`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python-base-debian)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python-base-debian
`DEBIAN_FRONTEND` | noninteractive

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
- `openssh-client`
- `python3`
- `python3-dev`
- `python3-pip`
- `wget`

## Python packages

Package | Version 
-- | --
`colorlog` | 6.6.0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM python:3.9-slim-buster

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=python-base-debian



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
        openssh-client \ 
        python3-dev \ 
        python3-pip \ 
        python3 \ 
        wget \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
        setuptools \ 
        wheel \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        colorlog==6.6.0 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
