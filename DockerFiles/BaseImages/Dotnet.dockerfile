FROM ludeeus/container:debian-base

COPY rootfs/dotnet-base /

ENV \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    CONTAINER_TYPE="dotnet"

RUN echo $(uname -a) \
    \
    && apt update \
    && apt install -y --no-install-recommends \
        libc6=2.28-10 \
        libgcc1=1:8.3.0-6 \
        libgssapi-krb5-2=1.17-3 \
        libicu63=63.1-6 \
        libssl1.1=1.1.1d-0+deb10u2 \
        libstdc++6=8.3.0-6 \
        zlib1g=1:1.2.11.dfsg-1 \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
    \
    && mkdir -p /dotnet \
    \
    && bash /build_scripts/download_dotnet.sh \
    \
    && tar zxf /tmp/runtime.tar.gz -C /dotnet \
    && tar zxf /tmp/sdk.tar.gz -C /dotnet \
    \
    && rm /tmp/*.gz \
    && rm -R /build_scripts \
    \
    && ln -s /dotnet/dotnet /bin/dotnet \
    \
    && chmod +x /usr/bin/dc