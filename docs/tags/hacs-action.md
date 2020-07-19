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

ENV CONTAINER_TYPE=hacs-action



RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        git=2.26.2-r0 \ 
        make=4.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3=3.8.3-r0 \ 
    && apk add --no-cache --virtual .build-deps  \ 
        ffmpeg-dev \ 
        gcc \ 
        libc-dev \ 
        libffi-dev \ 
        python3-dev \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        setuptools==49.2.0 \ 
        wheel==0.34.2 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && git clone https://github.com/hacs/integration.git /hacs \ 
    && cd /hacs \ 
    && make init \ 
    && rm -rf /var/cache/apk/* \ 
    && apk del --no-cache .build-deps \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*



<<<<<<< HEAD

=======
LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-17T16:44:39.813123"
LABEL org.opencontainers.image.description="This provides a container to run HACS actions inside."
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/hacs-action"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="93a0ea023913050ae699ec6c55be7deccd9e0732"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Hacs-Action"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/hacs-action"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="93a0ea023913050ae699ec6c55be7deccd9e0732"
>>>>>>> 589fbf4053c7812b821060e23794a83a031007b5
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
