ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV DEVCONTAINER=true

COPY ./container /container
COPY ./include /include

ARG CONTAINER_TYPE OS_VARIANT
RUN \
    bash /include/install/devcontainer/${OS_VARIANT}.sh ${CONTAINER_TYPE} \
    && bash /include/cleanup/python.sh \
    && bash /include/cleanup/build.sh