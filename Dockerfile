FROM debian:10.4-slim
ENV CONTAINER_TYPE='netdaemon'
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
COPY rootfs/netdaemon /
COPY rootfs/common /
RUN chmod +x /usr/bin/container && apt update && apt install -y --no-install-recommends --allow-downgrades ca-certificates nano bash wget git && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/* && bash /build_scripts/install && rm -R /build_scripts
LABEL maintainer='hi@ludeeus.dev'
LABEL build.date='2020-7-6'
LABEL build.sha='None'
