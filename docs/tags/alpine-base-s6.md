# alpine-base-s6

[Back to overview](../index.md)

**Base image**: `alpine:3.14.2`  
**Full name**: `ludeeus/container:alpine-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=alpine-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | alpine-base-s6
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.2.0.3)`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`git` | 2.32.0-r0
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.2

ENV CONTAINER_TYPE=alpine-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        git=2.32.0-r0 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
