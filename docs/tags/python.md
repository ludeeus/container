# python

[Back to overview](../index.md)

_This provides a minimalistic container for working with python._

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:python`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python
`DEVCONTAINER` | True

## Features

- `devcontainer`

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
`python3-dev` | 3.8.5-r0
`python3` | 3.8.5-r0

## Python packages

Package | Version 
-- | --
`black` | 20.8b1
`pylint` | 2.6.0
`setuptools` | 50.3.0
`wheel` | 0.35.1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV CONTAINER_TYPE=python
ENV DEVCONTAINER=True

COPY rootfs/common /
COPY --from=ludeeus/webhook /bin/binary /bin/webhook

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
        python3-dev=3.8.5-r0 \ 
        python3=3.8.5-r0 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==20.8b1 \ 
        pylint==2.6.0 \ 
        setuptools==50.3.0 \ 
        wheel==0.35.1 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
