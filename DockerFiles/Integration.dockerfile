FROM ludeeus/container:python-base

ENV CONTAINER_TYPE integration

COPY requirements.txt /tmp/

RUN mkdir -p /config/custom_components