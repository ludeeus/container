FROM ludeeus/container:alpine-base-s6

ARG ELASTIC_VERSION="7.6.2"

ENV ELASTIC_VERSION=${ELASTIC_VERSION}
ENV CONTAINER_TYPE=elastic-ek

RUN \
    apk add --no-cache \
        openjdk11=11.0.5_p10-r0 \
        nodejs=12.15.0-r1 \
        curl=7.67.0-r0 \
    \
    && adduser -S ekuser \
    && mkdir -p /data /esdata \
    && rm -rf /var/cache/apk/* \
    \
    && curl -L -s https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
        | tar xvzf - -C /usr/local \
        && mv /usr/local/elasticsearch-${ELASTIC_VERSION} /usr/local/elasticsearch \
    \
    && curl -L -s https://artifacts.elastic.co/downloads/kibana/kibana-oss-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
        | tar xvzf - -C /usr/local \
        && mv /usr/local/kibana-${ELASTIC_VERSION}-linux-x86_64 /usr/local/kibana \
    \
    # fix node installation (https://github.com/elastic/kibana/issues/17015)
    && rm -rf /usr/local/kibana/node \
    && mkdir -p /usr/local/kibana/node/bin \
    && ln -s /usr/bin/node /usr/local/kibana/node/bin/node \
    \
    # Fix for Kibana issue with node
    && sed -i 's/--max-http-header-size=65536//g' /usr/local/kibana/bin/kibana \
    && sed -i 's/!isVersionValid/isVersionValid/g' /usr/local/kibana/src/setup_node_env/node_version_validator.js \
    \
    # bind java
    && ln -sf /usr/bin/java /usr/local/elasticsearch/jdk/bin/java

COPY rootfs/elastic-ek /



ENTRYPOINT [ "/init" ]