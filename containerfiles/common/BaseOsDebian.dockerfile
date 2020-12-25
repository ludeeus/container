ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV DEBIAN_FRONTEND=noninteractive

COPY ./include /include

ARG OS_VARIANT INSTALL_S6
RUN \
    bash /include/install/base-${OS_VARIANT}.sh \
    && if [ -n "${INSTALL_S6}" ]; then bash /include/install/s6.sh; fi \
    && bash /include/cleanup-build.sh