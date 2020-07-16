# v

[Back to overview](../index.md)

_This provides a container for working with V._

**Base image**: `alpine:3.12.0`  
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
`bash` | 5.0.17-r0
`clang` | 10.0.0-r2
`gcc` | 9.3.0-r2
`git` | 2.26.2-r0
`make` | 4.3-r0
`musl-dev` | 1.1.24-r9
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`sqlite-dev` | 3.32.1-r0
`upx` | 3.96-r0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV VVV=/opt/vlang
ENV PATH=/opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CXX=clang++
ENV CC=clang
ENV CONTAINER_TYPE=v
ENV DEVCONTAINER=True

COPY rootfs/common /
COPY --from=ludeeus/webhook /bin/binary /bin/webhook

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        clang=10.0.0-r2 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        make=4.3-r0 \ 
        musl-dev=1.1.24-r9 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        sqlite-dev=3.32.1-r0 \ 
        upx=3.96-r0 \ 
    && chmod +x /usr/bin/container \ 
    && mkdir -p /opt/vlang \ 
    && ln -s /opt/vlang/v /usr/bin/v \ 
    && git clone https://github.com/vlang/v /opt/vlang \ 
    && cd /opt/vlang \ 
    && make \ 
    && v -version \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-16T21:20:24.254436"
LABEL org.opencontainers.image.description="This provides a container for working with V."
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/v"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="None"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="V"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/v"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="None"
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
