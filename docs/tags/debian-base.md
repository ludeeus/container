# debian-base

[Back to overview](../index.md)

**Base image**: `debian:10.4-slim`  
**Full name**: `ludeeus/container:debian-base`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=debian-base)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | debian-base
`DEBIAN_FRONTEND` | noninteractive

## Debian packages

- `bash`
- `ca-certificates`
- `git`
- `nano`
- `wget`



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM debian:10.4-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=debian-base



RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-18T16:44:28.714757"
LABEL org.opencontainers.image.description="None"
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/debian-base"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="589fbf4053c7812b821060e23794a83a031007b5"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Debian-Base"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/debian-base"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="589fbf4053c7812b821060e23794a83a031007b5"
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
