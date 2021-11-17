# hacs-action

[Back to overview](../index.md)

_This provides a container to run HACS actions inside._

**Base image**: `alpine:3.14.3`  
**Full name**: `ludeeus/container:hacs-action`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=hacs-action)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | hacs-action

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`git` | 2.32.0-r0
`make` | 4.3-r0
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0
`py3-pip` | 20.3.4-r1
`python3` | 3.9.5-r1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.3

ENV CONTAINER_TYPE=hacs-action



RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        git=2.32.0-r0 \ 
        make=4.3-r0 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
        py3-pip=20.3.4-r1 \ 
        python3=3.9.5-r1 \ 
    && apk add --no-cache --virtual .build-deps  \ 
        ffmpeg-dev \ 
        gcc \ 
        libc-dev \ 
        libffi-dev \ 
        python3-dev \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && git clone https://github.com/hacs/integration.git /hacs \ 
    && cd /hacs \ 
    && make init \ 
    && rm -rf /var/cache/apk/* \ 
    && apk del --no-cache .build-deps \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
