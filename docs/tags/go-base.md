# go-base

[Back to overview](../index.md)

**Base image**: `alpine:3.14.3`  
**Full name**: `ludeeus/container:go-base`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=go-base)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | go-base

## Alpine packages

Package | Version 
-- | --
`bash` | 5.1.4-r0
`git` | 2.32.0-r0
`go` | 1.16.8-r0
`openssh` | 8.6_p1-r3
`openssl-dev` | 1.1.1l-r0



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.14.3

ENV CONTAINER_TYPE=go-base



RUN  \ 
    apk add --no-cache  \ 
        bash=5.1.4-r0 \ 
        git=2.32.0-r0 \ 
        go=1.16.8-r0 \ 
        openssh=8.6_p1-r3 \ 
        openssl-dev=1.1.1l-r0 \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*




</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
