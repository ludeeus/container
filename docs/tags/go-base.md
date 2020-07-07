# go-base

[Back to overview](../index.md)

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:go-base`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=go-base)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | go-base

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`curl` | 7.69.1-r0
`git` | 2.26.2-r0
`go` | 1.13.11-r0
`nano` | 4.9.3-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0



***
<details>
<summary>Dockerfile</summary>

```dockerfile
FROM alpine:3.12.0

ENV CONTAINER_TYPE=go-base



RUN  \ 
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \ 
    && apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        curl=7.69.1-r0 \ 
        git=2.26.2-r0 \ 
        go=1.13.11-r0 \ 
        nano=4.9.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
    && rm -rf /var/cache/apk/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>