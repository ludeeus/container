ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include /include

RUN \
    bash /include/install/s6.sh \
    && bash /include/cleanup/build.sh