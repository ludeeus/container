FROM alpine:3.12.0
ENV CONTAINER_TYPE='v'
ENV VVV=/opt/vlang
ENV PATH=/opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY rootfs/common /
RUN chmod +x /usr/bin/container && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && apk add --no-cache openssl-dev=1.1.1g-r0 nano=4.9.3-r0 openssh=8.3_p1-r0 bash=5.0.17-r0 git=2.26.2-r0 curl=7.69.1-r0 gcc=9.3.0-r2 upx=3.96-r0 musl-dev=1.1.24-r9 sqlite-dev=3.32.1-r0 libx11-dev=1.6.9-r0 glfw-dev=3.3.2-r1 freetype-dev=2.10.2-r0 make=4.3-r0 sdl2=2.0.12-r1 sdl2-dev=2.0.12-r1 sdl2_ttf-dev=2.0.15-r0 sdl2_mixer-dev=2.0.4-r1 sdl2_image-dev=2.0.5-r2 && rm -rf /var/cache/apk/* && mkdir -p /opt/vlang && ln -s /opt/vlang/v /usr/bin/v && git clone https://github.com/vlang/v /opt/vlang && cd /opt/vlang && make && v -version
LABEL maintainer='hi@ludeeus.dev'
LABEL build.date='2020-7-6'
LABEL build.sha='None'
