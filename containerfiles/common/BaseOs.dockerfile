ARG BUILD_FROM
FROM ${BUILD_FROM}

COPY ./include /include

ARG OS_VARIANT INSTALL_S6
RUN \
    sh /include/install/base/${OS_VARIANT}.sh \
    && if [ -n "${INSTALL_S6}" ]; then bash /include/install/s6.sh; fi \
    && bash /include/cleanup/build.sh