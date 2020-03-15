FROM ludeeus/devcontainer:base

ENV NETVERSION "3.1.102"

ENV DEVCONTAINER_TYPE dotnet

RUN \
    apk add --no-cache \
        libintl=0.20.1-r2 \
        zlib=1.2.11-r3 \
        icu-dev=64.2-r0 \
        libcurl=7.67.0-r0 \
    \
    && wget -O /tmp/dotnet-install.sh https://dot.net/v1/dotnet-install.sh \
    \
    && bash /tmp/dotnet-install.sh --version ${NETVERSION} --install-dir "/root/.dotnet" --architecture "x64" \
    \
    && rm /tmp/dotnet-install.sh \
    \
    && ln -s /root/.dotnet/dotnet /bin/dotnet