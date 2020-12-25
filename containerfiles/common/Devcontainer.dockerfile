ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include /include

ARG OS_VARIANT CONTAINER_TYPE
RUN \
    bash /include/install/devcontainer/os/${OS_VARIANT}.sh \
    && bash /include/install/ghcli.sh \
    && bash /include/install/devcontainer/type/${CONTAINER_TYPE}.sh \
    && bash /include/cleanup/${OS_VARIANT}.sh \
    && bash /include/cleanup/build.sh