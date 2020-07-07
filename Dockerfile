FROM debian:10.4-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV CONTAINER_TYPE=netdaemon
ENV DEVCONTAINER=True

COPY rootfs/dotnet-base /
COPY rootfs/common /

RUN  \ 
    apt update \ 
    && apt install -y --no-install-recommends --allow-downgrades  \ 
        ca-certificates \ 
        nano \ 
        bash \ 
        wget \ 
        git \ 
        libc6 \ 
        libgcc1 \ 
        libgssapi-krb5-2 \ 
        libicu63 \ 
        libssl1.1 \ 
        libstdc++6 \ 
        zlib1g \ 
        procps \ 
    && chmod +x /usr/bin/container \ 
    && bash /build_scripts/install && rm -R /build_scripts \ 
    && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*



LABEL maintainer=hi@ludeeus.dev
LABEL build.date=2020-7-7
LABEL build.sha=None