# python-base

[Back to overview](../index.md)

**Base image**: `alpine:3.14.2`  
**Full name**: `ludeeus/container:python-base`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python-base)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python-base

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`ffmpeg-dev` | 4.4.1-r0
`gcc` | 10.3.1_git20210424-r2
`git` | 2.32.0-r0
`libc-dev` | 0.7.2-r3
`libffi-dev` | 3.3-r2
`make` | 4.3-r0
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0
`py3-pip` | 20.3.4-r1
`python3-dev` | 3.9.5-r1
`python3` | 3.9.5-r1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.2

ENV CONTAINER_TYPE=python-base



RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        ffmpeg-dev=4.4.1-r0 \ 
        gcc=10.3.1_git20210424-r2 \ 
        git=2.32.0-r0 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
        py3-pip=20.3.4-r1 \ 
        python3-dev=3.9.5-r1 \ 
        python3=3.9.5-r1 \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
