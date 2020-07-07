# debian-base-s6

[Back to overview](../index.md)

**Base image**: `debian:10.4-slim`  
**Full name**: `ludeeus/container:debian-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=debian-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | debian-base-s6
`DEBIAN_FRONTEND` | noninteractive
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.0.0.1)`

## Debian packages

- `bash`
- `ca-certificates`
- `git`
- `nano`
- `wget`



***
<details>
<summary>Dockerfile</summary>

```dockerfile
FROM debian:10.4-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=debian-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>
