# elastic-ek

[Back to overview](../index.md)

_Elasticsearch and Kibana in the same container_

**Base image**: [ludeeus/container:alpine-base](./alpine-base)  
**Full name**: `ludeeus/container:elastic-ek`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=elastic-ek)

## Environment variables

Variable | Value 
-- | --
CONTAINER_TYPE | elastic-ek
ELASTIC_VERSION | 7.8.0

## Features

Feature | Enabled 
-- | --
S6 overlay | True

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`curl` | 7.69.1-r0
`git` | 2.26.2-r0
`nano` | 4.9.3-r0
`nodejs` | 12.17.0-r0
`openjdk11` | 11.0.7_p10-r1
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0

## Additional information

This container can use 2 ports `9200` (for Elasticsearch) and `5601` for Kibana.
If you want to add local indices to elasticsearch, you can map that in with the `-v` option.

Example run:

```bash
docker run --name elastic -d -p 9200:9200 -p 5601:5601 C:\es\:/data ludeeus/contianer:elastic-ek
```