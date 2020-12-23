FROM alpine:3.12.3

ENV CONTAINER_TYPE=alpine-base



RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        git=2.26.2-r0 \ 
        openssh=8.3_p1-r1 \ 
        openssl-dev=1.1.1i-r0 \ 
    && rm -rf /var/cache/apk/* \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-12-23T18:41:48.025081"
LABEL org.opencontainers.image.description="None"
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/alpine-base"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="None"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Alpine-Base"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/alpine-base"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="None"