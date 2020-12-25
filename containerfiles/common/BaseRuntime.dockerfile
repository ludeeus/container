ARG BUILD_FROM
FROM ${BUILD_FROM}

COPY ./include /include

ARG INSTALL_RUNTIME RUNTIME_VERSION OS_VARIANT
RUN \
    bash /include/install/${INSTALL_RUNTIME}/${OS_VARIANT}.sh "${RUNTIME_VERSION}" \
    && bash /include/cleanup/${OS_VARIANT}.sh \
    && bash /include/cleanup/build.sh