# dotnet-base-s6

[Back to overview](../index.md)

**Base image**: `debian:10.6-slim`  
**Full name**: `ludeeus/container:dotnet-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=dotnet-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | dotnet-base-s6
`DEBIAN_FRONTEND` | noninteractive
`DOTNET_CLI_TELEMETRY_OPTOUT` | 1
`DOTNET_RUNNING_IN_CONTAINER` | true
`DOTNET_USE_POLLING_FILE_WATCHER` | true
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.1.0.2)`
- `dotnetcore-runtime (3.1.10)`
- `dotnetcore-sdk (3.1.404)`

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
- `openssh-client`
- `procps`
- `wget`
- `zlib1g`



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM debian:10.6-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV CONTAINER_TYPE=dotnet-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/dotnet-base /
COPY rootfs/s6/install /s6/install

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        openssh-client \ 
        libc6 \ 
        libgcc1 \ 
        libgssapi-krb5-2 \ 
        libicu63 \ 
        libssl1.1 \ 
        libstdc++6 \ 
        zlib1g \ 
        procps \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && bash /build_scripts/install \ 
    && rm -R /build_scripts \ 
    && mkdir -p /dotnet \ 
    && tar zxf /tmp/runtime.tar.gz -C /dotnet \ 
    && tar zxf /tmp/sdk.tar.gz -C /dotnet \ 
    && ln -s /dotnet/dotnet /bin/dotnet \ 
    && dotnet --info \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
