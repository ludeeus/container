FROM mcr.microsoft.com/dotnet/core/sdk:3.1.200-alpine

ENV \
    CONTAINER_TYPE="dotnet"

COPY rootfs /

RUN \
    dotnet help \
    \
    && chmod +x /usr/bin/dc