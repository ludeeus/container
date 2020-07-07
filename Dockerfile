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
        sdl2-dev=2.0.12-r1 \ 
        sdl2=2.0.12-r1 \ 
        sdl2_image-dev=2.0.5-r2 \ 
        sdl2_mixer-dev=2.0.4-r1 \ 
        sdl2_ttf-dev=2.0.15-r0 \ 
        sqlite-dev=3.32.1-r0 \ 
        upx=3.96-r0 \ 
    && rm -rf /var/cache/apk/* \ 
    && chmod +x /usr/bin/container



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None