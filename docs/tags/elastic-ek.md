# elastic-ek

[Back to overview](../index.md)

_Elasticsearch and Kibana in the same container_

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:elastic-ek`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=elastic-ek)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | elastic-ek
`ELASTIC_VERSION` | 7.8.0
`S6_BEHAVIOUR_IF_STAGE2_FAILS` | 2
`S6_CMD_WAIT_FOR_SERVICES` | 1

## Features

- `S6 (v2.1.0.0)`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`curl` | 7.69.1-r1
`git` | 2.26.2-r0
`nodejs` | 12.18.4-r0
`openjdk11` | 11.0.8_p10-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0

## Additional information

This container can use 2 ports `9200` (for Elasticsearch) and `5601` for Kibana.
If you want to add local indices to elasticsearch, you can map that in with the `-v` option.

Example run:

```bash
docker run --name elastic -d -p 9200:9200 -p 5601:5601 C:\es\:/data ludeeus/contianer:elastic-ek
```



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV ELASTIC_VERSION=7.8.0
ENV CONTAINER_TYPE=elastic-ek
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/elastic-ek /
COPY rootfs/s6/install /s6/install

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        curl=7.69.1-r1 \ 
        git=2.26.2-r0 \ 
        nodejs=12.18.4-r0 \ 
        openjdk11=11.0.8_p10-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
    && bash /s6/install \ 
    && rm -R /s6 \ 
    && adduser -S ekuser \ 
    && mkdir -p /data /esdata \ 
    && bash /build_scripts/install \ 
    && ln -sf /usr/bin/java /usr/local/elasticsearch/jdk/bin/java \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*

ENTRYPOINT ['/init']


</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
