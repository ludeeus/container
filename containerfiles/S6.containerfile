ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include/cleanup /include/cleanup

ARG OS_VARIANT
COPY ./include/install/s6 /include/install/s6
RUN bash /include/install/s6/${OS_VARIANT}.sh


RUN bash /include/cleanup/build.sh