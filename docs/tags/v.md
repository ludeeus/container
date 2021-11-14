# v

[Back to overview](../index.md)

_This provides a container for working with V._

**Base image**: `alpine:3.14.3`  
**Full name**: `ludeeus/container:v`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=v)

## Environment variables

Variable | Value 
-- | --
`CC` | clang
`CONTAINER_TYPE` | v
`CXX` | clang++
`DEVCONTAINER` | True
`PATH` | /opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
`VVV` | /opt/vlang

## Features

- `devcontainer`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`clang` | 11.1.0-r1
`gcc` | 10.3.1_git20210424-r2
`git` | 2.32.0-r0
`make` | 4.3-r0
`musl-dev` | 1.2.2-r3
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0
`sqlite-dev` | 3.35.5-r0
`upx` | 3.96-r1



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.3

ENV VVV=/opt/vlang
ENV PATH=/opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CXX=clang++
ENV CC=clang
ENV CONTAINER_TYPE=v
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        clang=11.1.0-r1 \ 
        gcc=10.3.1_git20210424-r2 \ 
        git=2.32.0-r0 \ 
        make=4.3-r0 \ 
        musl-dev=1.2.2-r3 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
        sqlite-dev=3.35.5-r0 \ 
        upx=3.96-r1 \ 
    && chmod +x /usr/bin/container \ 
    && mkdir -p /opt/vlang \ 
    && ln -s /opt/vlang/v /usr/bin/v \ 
    && git clone https://github.com/vlang/v /opt/vlang \ 
    && cd /opt/vlang \ 
    && make \ 
    && v -version \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
