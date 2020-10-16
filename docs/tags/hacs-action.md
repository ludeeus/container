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
`git` | 2.26.2-r0
`make` | 4.3-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`py3-pip` | 20.1.1-r0
`python3` | 3.8.5-r0

## Python packages

Package | Version 
-- | --
`setuptools` | 50.3.1
`wheel` | 0.35.1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV CONTAINER_TYPE=hacs-action



RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        git=2.26.2-r0 \ 
        make=4.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3=3.8.5-r0 \ 
    && apk add --no-cache --virtual .build-deps  \ 
        ffmpeg-dev \ 
        gcc \ 
        libc-dev \ 
        libffi-dev \ 
        python3-dev \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        setuptools==50.3.1 \ 
        wheel==0.35.1 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && git clone https://github.com/hacs/integration.git /hacs \ 
    && cd /hacs \ 
    && make init \ 
    && rm -rf /var/cache/apk/* \ 
    && apk del --no-cache .build-deps \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
