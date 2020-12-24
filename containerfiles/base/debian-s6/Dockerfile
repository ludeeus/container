ARG BASE
FROM ${BASE}

ENV DEBIAN_FRONTEND=noninteractive

COPY ./include /include

ARG OS_VARIANT
RUN \
    bash /include/install/base-${OS_VARIANT}.sh \
    && bash /include/install/s6.sh \
    && bash /include/cleanup-build.sh