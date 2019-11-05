FROM ludeeus/devcontainer:base

ENV DEVCONTAINER_TYPE frontend

RUN \
    apk add --no-cache \
        nodejs=10.16.3-r0 \
        npm=10.16.3-r0 \
        yarn=1.16.0-r0