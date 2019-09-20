echo Welcome to this custom devcontainer for developing/testing custom integrations for Home Assistant.
echo
echo For the documentation for this container have a look here:
echo https://github.com/ludeeus/devcontainer
echo
cp -R /tmp/.ssh /root/.ssh
chmod 700 /root/.ssh
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa
