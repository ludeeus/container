ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include /include

ARG RUNTIME_PATHS
ENV PATH ${RUNTIME_PATHS}$PATH

ARG OS_VARIANT CONTAINER_TYPE
RUN \
    sh /include/init.sh \
    && bash /include/install/devcontainer/${OS_VARIANT}.sh \
    && bash /include/install/ghcli/${OS_VARIANT}.sh \
    && bash /include/install/container/${OS_VARIANT}.sh \
    && if [ -f /include/install/devcontainer/${CONTAINER_TYPE}.sh ]; then \
        bash /include/install/devcontainer/${CONTAINER_TYPE}.sh ${OS_VARIANT}; \
    fi \
    && bash /include/cleanup/${OS_VARIANT}.sh \
    && bash /include/cleanup/build.sh