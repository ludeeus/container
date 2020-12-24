FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include /include

RUN \
    bash /include/install/ghcli-debian.sh \
    && bash /include/install/container.sh python \
    && bash /include/cleanup-debian.sh