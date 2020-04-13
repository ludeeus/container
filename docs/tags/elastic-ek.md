# elastic-ek

[Back to overview](../index.md)

**Base image**: [ludeeus/container:alpine-base](./alpine-base)

**Full name**: `ludeeus/container:elastic-ek`

## Environment variables

Variable | Value 
-- | --
CONTAINER_TYPE | elastic-ek
ELASTIC_VERSION | 7.6.2

## Features

Feature | Enabled 
-- | --
S6 overlay | False

## Alpine packages

Package | Version 
-- | --
`openjdk11` | 11.0.5_p10-r0
`nodejs` | 12.15.0-r1

## Additional information

This container can use 2 ports `9200` (for Elasticsearch) and `5601` for Kibana.
If you want to add local indices to elasticsearch, you can map that in with the `-v` option.

Example run:

```bash
docker run --name elastic -d -p 9200:9200 -p 5601:5601 C:\es\:/data ludeeus/contianer:elastic-ek
```