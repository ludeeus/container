# python-base-debian

[Back to overview](../index.md)

**Base image**: `debian:10.6-slim`  
**Full name**: `ludeeus/container:python-base-debian`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=python-base-debian)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | python-base-debian
`DEBIAN_FRONTEND` | noninteractive

## Debian packages

- `bash`
- `ca-certificates`
- `gcc`
- `git`
- `libavcodec-dev`
- `libc-dev`
- `libffi-dev`
- `make`
- `nano`
- `python3`
- `python3-dev`
- `python3-pip`
- `wget`



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM debian:10.6-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=python-base-debian



RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        gcc \ 
        libc-dev \ 
        libffi-dev \ 
        libavcodec-dev \ 
        python3-dev \ 
        make \ 
        python3 \ 
        python3-pip \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
