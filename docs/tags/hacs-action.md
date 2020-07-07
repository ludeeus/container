# hacs-action

[Back to overview](../index.md)

_This provides a container to run HACS actions inside._

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:hacs-action`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=hacs-action)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | hacs-action

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`curl` | 7.69.1-r0
`ffmpeg-dev` | 4.3-r0
`gcc` | 9.3.0-r2
`git` | 2.26.2-r0
`libc-dev` | 0.7.2-r3
`libffi-dev` | 3.3-r2
`make` | 4.3-r0
`nano` | 4.9.3-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`py3-pip` | 20.1.1-r0
`python3-dev` | 3.8.3-r0
`python3` | 3.8.3-r0

## Pyhton packages

Package | Version 
-- | --
`black` | 19.10b0
`colorlog` | 4.1.0
`pylint` | 2.5.3
`python-language-server` | 0.34.1



***
<details>
<summary>Dockerfile</summary>

```dockerfile
FROM alpine:3.12.0

ENV CONTAINER_TYPE=hacs-action



RUN  \ 
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \ 
    && apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        curl=7.69.1-r0 \ 
        ffmpeg-dev=4.3-r0 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        nano=4.9.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3-dev=3.8.3-r0 \ 
        python3=3.8.3-r0 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==19.10b0 \ 
        colorlog==4.1.0 \ 
        pylint==2.5.3 \ 
        python-language-server==0.34.1 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && git clone https://github.com/hacs/integration.git /hacs \ 
    && cd /hacs \ 
    && python -m pip --disable-pip-version-check install -U setuptools wheel \ 
    && python -m pip --disable-pip-version-check install -r requirements.txt \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \;



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>
