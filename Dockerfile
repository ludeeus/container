FROM alpine:3.12.3

ENV CONTAINER_TYPE=integration
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        ffmpeg-dev=4.3.1-r0 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        jpeg-dev=9d-r0 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        openssh=8.3_p1-r1 \ 
        openssl-dev=1.1.1i-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3-dev=3.8.5-r0 \ 
        python3=3.8.5-r0 \ 
        zlib-dev=1.2.11-r3 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
        setuptools \ 
        wheel \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==20.8b1 \ 
        pylint==2.6.0 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && mkdir -p /config/custom_components \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*



LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-12-24T01:10:03.852544"
LABEL org.opencontainers.image.description="This provides a minimalistic container for working with python."
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/integration"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="None"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Integration"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/integration"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="None"