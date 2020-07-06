FROM alpine:3.12.0
ENV CONTAINER_TYPE='hacs-action'
COPY rootfs/common /
RUN chmod +x /usr/bin/container && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && apk add --no-cache openssl-dev=1.1.1g-r0 nano=4.9.3-r0 openssh=8.3_p1-r0 bash=5.0.17-r0 git=2.26.2-r0 curl=7.69.1-r0 gcc=9.3.0-r2 libc-dev=0.7.2-r3 libffi-dev=3.3-r2 ffmpeg-dev=4.3-r0 python3-dev=3.8.3-r0 make=4.3-r0 python3=3.8.3-r0 && rm -rf /var/cache/apk/* && ln -s /usr/bin/python3 /usr/bin/python && git clone https://github.com/hacs/integration.git /hacs && cd /hacs && python -m pip --disable-pip-version-check install -U setuptools wheel && python -m pip --disable-pip-version-check install -r requirements.txt
LABEL maintainer='hi@ludeeus.dev'
LABEL build.date='2020-7-6'
LABEL build.sha='None'
