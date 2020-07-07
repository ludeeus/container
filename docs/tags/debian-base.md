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
<summary>Dockerfile</summary>

```dockerfile
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
    && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>
