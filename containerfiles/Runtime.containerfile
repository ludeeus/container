ARG BUILD_FROM BUILD_FROM_TAG
FROM ${BUILD_FROM}:${BUILD_FROM_TAG}

COPY ./include/cleanup /include/cleanup

ARG RUNTIME_PATH
ENV PATH ${RUNTIME_PATH}:$PATH

ARG INSTALL_RUNTIME OS_VARIANT
COPY ./include/install/${INSTALL_RUNTIME} /include/install/${INSTALL_RUNTIME}
RUN bash /include/install/${INSTALL_RUNTIME}/${OS_VARIANT}.sh

ARG OS_VARIANT
RUN bash /include/cleanup/${OS_VARIANT}.sh

RUN bash /include/cleanup/build.sh