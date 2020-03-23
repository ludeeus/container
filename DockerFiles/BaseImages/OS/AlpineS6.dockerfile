FROM ludeeus/container:alpine-base

ENV \
    CONTAINER_TYPE="alpine-base-s6" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1

COPY rootfs/s6/install /s6/install

RUN \
    bash /s6/install \
    \
    && rm -R /s6