# nodejs-base-s6

[Back to overview](../index.md)

**Base image**: `alpine:3.12.3`  
**Full name**: `ludeeus/container:nodejs-base-s6`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=nodejs-base-s6)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | nodejs-base-s6
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.1.0.2)`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`git` | 2.26.2-r0
`nodejs` | 12.20.1-r0
`npm` | 12.20.1-r0
`openssh` | 8.3_p1-r1
`openssl-dev` | 1.1.1i-r0
`yarn` | 1.22.4-r0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.3

ENV CONTAINER_TYPE=nodejs-base-s6
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        git=2.26.2-r0 \ 
        nodejs=12.20.1-r0 \ 
        npm=12.20.1-r0 \ 
        openssh=8.3_p1-r1 \ 
        openssl-dev=1.1.1i-r0 \ 
        yarn=1.22.4-r0 \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
