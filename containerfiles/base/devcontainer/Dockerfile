FROM mcr.microsoft.com/vscode/devcontainers/base:debian-10

ENV DEBIAN_FRONTEND=noninteractive
ENV DEVCONTAINER=true

COPY ./include /tmp/include

RUN \
    apt update \
    && apt install -y software-properties-common \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
    && apt-add-repository https://cli.github.com/packages \
    && apt update \
    && apt install -y gh \
    && bash /tmp/include/container.sh \
    \
    && rm -fr /tmp/include \
    && rm -fr /var/lib/apt/lists/* \
    && rm -fr /tmp/* /var/{cache,log}/*
