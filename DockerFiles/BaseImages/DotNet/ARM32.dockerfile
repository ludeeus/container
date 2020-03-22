FROM ludeeus/container:debian-base

# https://dotnet.microsoft.com/download/dotnet-core/3.1
ARG SDK_URL="https://download.visualstudio.microsoft.com/download/pr/21a124fd-5bb7-403f-bdd2-489f9d21d695/b58fa90d19a5a5124d21dea94422868c/dotnet-sdk-3.1.200-linux-arm.tar.gz"
ARG RUNTIME_URL="https://download.visualstudio.microsoft.com/download/pr/30ed47bb-c25b-431c-9cfd-7b942b07314f/5c92af345a5475ca58b6878dd974e1dc/dotnet-runtime-3.1.2-linux-arm.tar.gz"

ENV \
    DOTNET_RUNNING_IN_CONTAINER="true" \
    DOTNET_USE_POLLING_FILE_WATCHER="true" \
    DEVCONTAINER_TYPE="dotnet"

RUN \
    echo $(uname -a) \
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
    && rm -rf /var/lib/apt/lists/* \
    \
    && mkdir -p /dotnet \
    \
    && wget -q -nv -O /tmp/runtime.tar.gz ${RUNTIME_URL} \
    && wget -q -nv -O /tmp/sdk.tar.gz ${SDK_URL} \
    \
    && tar zxf /tmp/runtime.tar.gz -C /dotnet \
    && tar zxf /tmp/sdk.tar.gz -C /dotnet \
    \
    && rm /tmp/*.gz \
    \
    && chmod root:root -R /dotnet/dotnet \
    && ln -s /dotnet/dotnet /bin/dotnet \
    \
    && ls -la /dotnet/host/fxr/3.1.2/ \
    \
    && dotnet help \
    \
    && chmod +x /usr/bin/dc