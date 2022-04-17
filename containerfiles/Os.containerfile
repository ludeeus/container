ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include /include


RUN sh /include/init.sh

ARG OS_VARIANT
RUN sh /include/install/base/${OS_VARIANT}.sh
RUN bash /include/cleanup/build.sh