ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include/cleanup /include/cleanup

COPY ./include/init.sh /include/init.sh
RUN sh /include/init.sh

ARG OS_VARIANT
COPY ./include/install/base/${OS_VARIANT}.sh /include/install/base/${OS_VARIANT}.sh
RUN sh /include/install/base/${OS_VARIANT}.sh

RUN bash /include/cleanup/build.sh
