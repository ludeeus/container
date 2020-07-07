# dotnet-base

[Back to overview](../index.md)

**Base image**: `debian:10.4-slim`  
**Full name**: `ludeeus/container:dotnet-base`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=dotnet-base)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | dotnet-base
`DEBIAN_FRONTEND` | noninteractive
`DOTNET_RUNNING_IN_CONTAINER` | true
`DOTNET_USE_POLLING_FILE_WATCHER` | true

## Features

- `dotnetcore-runtime (3.1.5)`
- `dotnetcore-sdk (3.1.301)`

## Debian packages

- `bash`
- `ca-certificates`
- `git`
- `libc6`
- `libgcc1`
- `libgssapi-krb5-2`
- `libicu63`
- `libssl1.1`
- `libstdc++6`
- `nano`
- `procps`
- `wget`
- `zlib1g`



***
<details>
<summary>Dockerfile</summary>

```dockerfile
FROM debian:10.4-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV CONTAINER_TYPE=dotnet-base

COPY rootfs/dotnet-base /

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        libc6 \ 
        libgcc1 \ 
        libgssapi-krb5-2 \ 
        libicu63 \ 
        libssl1.1 \ 
        libstdc++6 \ 
        zlib1g \ 
        procps \ 
    && bash /build_scripts/install && rm -R /build_scripts \ 
    && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None
```
</details>
