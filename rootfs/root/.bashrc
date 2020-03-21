#!/bin/bash
source /etc/bash_completion.d/dc_completion
git config --global core.autocrlf input > /dev/null 2>&1

export PS1="devcontainer# "
export DEVCONTAINER="True"

declare element

# Copy SSH keys if they exsist
if test -d "/tmp/.ssh"; then
    cp -R /tmp/.ssh /root/.ssh > /dev/null 2>&1
    chmod 700 /root/.ssh > /dev/null 2>&1
    chmod 644 /root/.ssh/id_rsa.pub > /dev/null 2>&1
    chmod 600 /root/.ssh/id_rsa > /dev/null 2>&1
fi

if [[ "$CONTAINER_TYPE" == "integration" ]]; then
    element="custom integrations for Home Assistant."
elif [[ "$CONTAINER_TYPE" == "frontend" ]]; then
    element="custom frontend elements."
elif [[ "$CONTAINER_TYPE" == "monster" ]]; then
    element="custom frontend elements and custom integrations for Home Assistant."
elif [[ "$CONTAINER_TYPE" == "netdaemon" ]]; then
    element="NetDaemon apps."
elif [[ "$CONTAINER_TYPE" == "dotnet" ]]; then
    element="dotnet."
else
    element="things."
fi


echo Welcome to this custom devcontainer for developing/testing "$element"
echo
echo For the documentation for this container have a look here:
echo https://github.com/ludeeus/devcontainer
echo