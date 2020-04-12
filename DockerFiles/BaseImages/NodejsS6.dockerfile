FROM ludeeus/container:alpine-base-s6

ENV CONTAINER_TYPE=nodejs-base-s6

RUN \
    apk add --no-cache \
        nodejs=12.15.0-r1 \
        npm=12.15.0-r1 \
        yarn=1.19.2-r0 \
    \
    && rm -rf /var/cache/apk/*