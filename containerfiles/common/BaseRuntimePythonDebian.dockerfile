ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV DEBIAN_FRONTEND=noninteractive

COPY ./container /container
COPY ./include /include

ARG PYTHON_PATH=/usr/local/python
ENV PIPX_HOME=/usr/local/py-utils \
    PIPX_BIN_DIR=/usr/local/py-utils/bin
ENV PATH=${PYTHON_PATH}/bin:${PATH}:${PIPX_BIN_DIR}

ARG PYTHON_VERSION OS_VARIANT
RUN \
    bash /include/install/python-${OS_VARIANT}.sh "${PYTHON_VERSION}" "${PYTHON_PATH}" "${PIPX_HOME}" \
    && bash /include/cleanup-${OS_VARIANT}.sh \
    && bash /include/cleanup-python.sh \
    && bash /include/cleanup-build.sh