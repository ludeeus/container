FROM ludeeus/devcontainer:python

ENV DEVCONTAINER_TYPE integration

COPY requirements.txt /tmp/

RUN mkdir -p /config/custom_components