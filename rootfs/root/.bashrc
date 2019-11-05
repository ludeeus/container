#!/bin/bash
source /etc/bash_completion.d/dc_completion

declare element

# Copy SSH keys if they exsist
if test -d "/tmp/.ssh"; then
    cp -R /tmp/.ssh /root/.ssh
    chmod 700 /root/.ssh
    chmod 644 /root/.ssh/id_rsa.pub
    chmod 600 /root/.ssh/id_rsa
fi

if [[ "$DEVCONTAINER_TYPE" == "integration" ]]; then
    element="custom integrations for Home Assistant."
elif [[ "$DEVCONTAINER_TYPE" == "frontend" ]]; then
    element="custom frontend elements."
elif [[ "$DEVCONTAINER_TYPE" == "base" ]]; then
    element="things."
elif [[ "$DEVCONTAINER_TYPE" == "monster" ]]; then
    element="custom frontend elements and custom integrations for Home Assistant."
fi


echo Welcome to this custom devcontainer for developing/testing "$element"
echo
echo For the documentation for this container have a look here:
echo https://github.com/ludeeus/devcontainer
echo