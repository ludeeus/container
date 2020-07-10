# dotnet-base-s6

[Back to overview](../index.md)

**Base image**: `debian:10.4-slim`  
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

- `S6 (v2.0.0.1)`
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

