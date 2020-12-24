ARG BASE
FROM ${BASE}

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include /include

ARG CONTAINER_TYPE OS_VARIANT
RUN \
    bash /include/install/ghcli-${OS_VARIANT}.sh \
    && bash /include/install/container.sh ${CONTAINER_TYPE} \
    && bash /include/cleanup-${OS_VARIANT}.sh \
    && bash /include/cleanup-python.sh \
    && bash /include/cleanup-build.sh