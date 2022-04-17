ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include/cleanup /include/cleanup
COPY ./include/install/devcontainer /include/install/devcontainer

ARG RUNTIME_PATHS
ENV PATH ${RUNTIME_PATHS}$PATH

ARG OS_VARIANT
RUN bash /include/install/devcontainer/${OS_VARIANT}.sh

ARG OS_VARIANT
RUN bash /include/install/ghcli/${OS_VARIANT}.sh

ARG OS_VARIANT CONTAINER_TYPE
RUN bash /include/install/container/${OS_VARIANT}.sh ${CONTAINER_TYPE} \

ARG CONTAINER_TYPE OS_VARIANT
RUN \
    if [ -f /include/install/devcontainer/${CONTAINER_TYPE}.sh ]; then \
        bash /include/install/devcontainer/${CONTAINER_TYPE}.sh ${OS_VARIANT}; \
    fi \

ARG OS_VARIANT
RUN bash /include/cleanup/${OS_VARIANT}.sh

RUN bash /include/cleanup/build.sh