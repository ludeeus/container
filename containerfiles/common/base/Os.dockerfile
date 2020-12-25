ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include /include

ARG OS_VARIANT
RUN \
    sh /include/install/base/${OS_VARIANT}.sh \
    && bash /include/cleanup/build.sh