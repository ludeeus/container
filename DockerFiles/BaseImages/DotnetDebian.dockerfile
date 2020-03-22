FROM ludeeus/container:debian-base

ENV \
    NETVERSION="3.1.200" \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    CONTAINER_TYPE="dotnet"

RUN \
    apt update \
    && apt install -y --no-install-recommends \
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
    && if [ "$(uname -m)" != "x86_64" ]; then export ARCH="arm"; else export ARCH="auto"; fi \
    \
    && bash /tmp/dotnet-install.sh --version ${NETVERSION} --install-dir "/root/.dotnet" --architecture ${ARCH} \
    \
    && rm /tmp/dotnet-install.sh \
    \
    && ln -s /root/.dotnet/dotnet /bin/dotnet \
    \
    && dotnet help \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \