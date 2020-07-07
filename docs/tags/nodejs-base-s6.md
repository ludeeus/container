# nodejs-base-s6

[Back to overview](../index.md)

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:nodejs-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=nodejs-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | nodejs-base-s6
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.0.0.1)`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`curl` | 7.69.1-r0
`git` | 2.26.2-r0
`nano` | 4.9.3-r0
`nodejs` | 12.17.0-r0
`npm` | 12.17.0-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`yarn` | 1.22.4-r0



***
<details>
<summary>Dockerfile</summary>

```dockerfile
FROM alpine:3.12.0

ENV CONTAINER_TYPE=nodejs-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN  \ 
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \ 
    && apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        curl=7.69.1-r0 \ 
        git=2.26.2-r0 \ 
        nano=4.9.3-r0 \ 
        nodejs=12.17.0-r0 \ 
        npm=12.17.0-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        yarn=1.22.4-r0 \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && rm -rf /var/cache/apk/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>
