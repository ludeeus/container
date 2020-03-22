FROM ludeeus/container:alpine-base

ENV \
    NETVERSION="3.1.200" \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    CONTAINER_TYPE="dotnet"

RUN \
    apk add --no-cache \
        icu-libs \
        ca-certificates \
        krb5-libs \
        libgcc \
        gcc \
        libintl \
        libssl1.1 \
        libstdc++ \
        zlib \
    \
    && wget -O /tmp/dotnet-install.sh https://dot.net/v1/dotnet-install.sh \
    \
    && sed -i 's|-$osname-|-linux-|' /tmp/dotnet-install.sh \
    \
    && bash /tmp/dotnet-install.sh --version ${NETVERSION} --install-dir "/root/.dotnet" \
    \
    && rm /tmp/dotnet-install.sh \
    \
    && ln -s /root/.dotnet/dotnet /bin/dotnet \
    \
    && dotnet help \
    \
    && rm -rf /var/cache/apk/*