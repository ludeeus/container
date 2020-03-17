FROM ludeeus/devcontainer:base-debian

ENV \
    NETVERSION="3.1.200" \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    DEVCONTAINER_TYPE="dotnet"

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu63 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
    \
    && wget -O /tmp/dotnet-install.sh https://dot.net/v1/dotnet-install.sh \
    \
    && bash /tmp/dotnet-install.sh --version ${NETVERSION} --install-dir "/root/.dotnet" --architecture "x64" \
    \
    && rm /tmp/dotnet-install.sh \
    \
    && ln -s /root/.dotnet/dotnet /bin/dotnet \
    \
    && dotnet help