FROM debian:10.7-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_TYPE=debian-base



RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        openssh-client \ 
    && rm -fr /var/lib/apt/lists/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-12-23T19:48:05.518469"
LABEL org.opencontainers.image.description="None"
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/debian-base"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="None"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Debian-Base"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/debian-base"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="None"