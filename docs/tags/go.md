# go

[Back to overview](../index.md)

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:go`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=go)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | go
`DEVCONTAINER` | True

## Features

- `devcontainer`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`git` | 2.26.2-r0
`go` | 1.13.14-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV CONTAINER_TYPE=go
ENV DEVCONTAINER=True

COPY rootfs/common /
COPY --from=ludeeus/webhook /bin/binary /bin/webhook

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        git=2.26.2-r0 \ 
        go=1.13.14-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
    && chmod +x /usr/bin/container \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-17T16:44:39.301563"
LABEL org.opencontainers.image.description="None"
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/go"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="93a0ea023913050ae699ec6c55be7deccd9e0732"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Go"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/go"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="93a0ea023913050ae699ec6c55be7deccd9e0732"
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
