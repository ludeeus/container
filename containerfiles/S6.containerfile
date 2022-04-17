ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include /include

RUN bash /include/init.sh
ARG OS_VARIANT
RUN bash /include/install/s6/${OS_VARIANT}.sh
RUN bash /include/cleanup/build.sh