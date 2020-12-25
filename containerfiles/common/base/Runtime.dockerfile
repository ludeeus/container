ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include /include

ARG RUNTIME_PATH
ENV PATH ${RUNTIME_PATH}:$PATH

ARG INSTALL_RUNTIME RUNTIME_VERSION OS_VARIANT
RUN \
    bash /include/install/${INSTALL_RUNTIME}/${OS_VARIANT}.sh "${RUNTIME_VERSION}" \
    && bash /include/cleanup/${OS_VARIANT}.sh \
    && bash /include/cleanup/build.sh