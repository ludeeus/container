# debian-base

[Back to overview](../index.md)

**Base image**: `debian:10.5-slim`  
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
FROM debian:10.5-slim

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




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
