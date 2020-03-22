FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster-arm64v8

ENV \
    CONTAINER_TYPE="dotnet"

COPY rootfs /


RUN \
    echo $(uname -a) \
    \
    && dotnet help \
    \
    && chmod +x /usr/bin/dc