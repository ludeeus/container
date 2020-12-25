ARG BUILD_FROM
FROM ${BUILD_FROM}

COPY ./include /include

RUN \
    bash /include/install/s6.sh \
    && bash /include/cleanup/build.sh