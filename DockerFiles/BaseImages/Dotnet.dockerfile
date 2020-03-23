FROM ludeeus/container:debian-base

COPY rootfs/dotnet-base /

ENV \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    DEVCONTAINER_TYPE="dotnet"

RUN echo $(uname -a) \
    \
    && apt update \
    && apt install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu63 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
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