FROM alpine:3.12.0

ENV VVV=/opt/vlang
ENV PATH=/opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CONTAINER_TYPE=v
ENV DEVCONTAINER=True

COPY rootfs/common /

RUN  \ 
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \ 
    && apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        curl=7.69.1-r0 \ 
        freetype-dev=2.10.2-r0 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        glfw-dev=3.3.2-r1 \ 
        libx11-dev=1.6.9-r0 \ 
        make=4.3-r0 \ 
        musl-dev=1.1.24-r9 \ 
        nano=4.9.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        sqlite-dev=3.32.1-r0 \ 
        upx=3.96-r0 \ 
    && apk add --no-cache --virtual .build-deps  \ 
        sdl2 \ 
        sdl2-dev \ 
        sdl2_image-dev \ 
        sdl2_mixer-dev \ 
        sdl2_ttf-dev \ 
    && chmod +x /usr/bin/container \ 
    && mkdir -p /opt/vlang \ 
    && ln -s /opt/vlang/v /usr/bin/v \ 
    && git clone https://github.com/vlang/v /opt/vlang \ 
    && cd /opt/vlang \ 
    && make \ 
    && v -version \ 
    && rm -rf /var/cache/apk/* \ 
    && apk del .build-deps



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None