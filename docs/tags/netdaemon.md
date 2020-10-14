# netdaemon

[Back to overview](../index.md)

**Base image**: `debian:10.6-slim`  
**Full name**: `ludeeus/container:netdaemon`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=netdaemon)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | netdaemon
`DEBIAN_FRONTEND` | noninteractive
`DEVCONTAINER` | True
`DOTNET_CLI_TELEMETRY_OPTOUT` | 1
`DOTNET_RUNNING_IN_CONTAINER` | true
`DOTNET_USE_POLLING_FILE_WATCHER` | true

## Features

- `devcontainer`
- `dotnetcore-runtime (3.1.9)`
- `dotnetcore-sdk (3.1.403)`

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
- `make`
- `nano`
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
ENV CONTAINER_TYPE=netdaemon
ENV DEVCONTAINER=True

COPY rootfs/dotnet-base /
COPY rootfs/common /
COPY --from=ludeeus/webhook /bin/binary /bin/webhook

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
        make \ 
    && chmod +x /usr/bin/container \ 
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
