#!/bin/bash
source /etc/bash_completion.d/container_completion
source /usr/share/container/tools
git config --global core.autocrlf input > /dev/null 2>&1

export PS1="container# "
export DEVCONTAINER="True"
export CONTAINER="True"

declare element

# Copy SSH keys if they exsist
if test -d "/tmp/.ssh"; then
    cp -R /tmp/.ssh /root/.ssh > /dev/null 2>&1
    chmod 700 /root/.ssh > /dev/null 2>&1
    chmod 644 /root/.ssh/id_rsa.pub > /dev/null 2>&1
    chmod 600 /root/.ssh/id_rsa > /dev/null 2>&1
fi

# Place node_modules inside the container
if test -f "$(GetWorkspaceName)package.json"; then
    if [ ! -d "$(GetWorkspaceName)node_modules" ]; then
        mkdir -p /tmp/node_modules
        ln -sf /tmp/node_modules "$(GetWorkspaceName)node_modules"
    fi
fi

# Set element for MOTD
if [[ "$CONTAINER_TYPE" == "integration" ]]; then
    element="custom integrations for Home Assistant"
elif [[ "$CONTAINER_TYPE" == "frontend" ]]; then
    element="frontend things"
elif [[ "$CONTAINER_TYPE" == "netdaemon" ]]; then
    element="NetDaemon apps"
elif [[ "$CONTAINER_TYPE" == "dotnet" ]]; then
    element="dotnet"
else
    element="things"
fi

complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make


echo Welcome to this custom devcontainer for developing/testing "$element"
echo
echo For the documentation for this devcontainer have a look here:
echo https://github.com/ludeeus/container
echo
