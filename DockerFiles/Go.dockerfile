FROM ludeeus/container:alpine-base

ENV CONTAINER_TYPE=go

RUN \
    apk add --no-cache \
        go=1.13.4-r1 \
    \
    && rm -rf /var/cache/apk/*
