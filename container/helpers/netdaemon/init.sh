#!/usr/bin/env bash
# shellcheck source=/dev/null

source /opt/container/helpers/common/paths.sh


if test -d "$(GetWorkspaceName).git"; then
    echo ".git exsist in $(GetWorkspaceName), existing initializing"
    exit 1
fi

echo "Initializing dev env for netdaemon"
rm -R /tmp/init > /dev/null 2>&1

echo "Before you get started we need some information to set it up"
echo
read -p -r 'What IP is Home Assistant running on? ' HA_IP
read -p -r 'What is the Home Assistant security token that Netdaemon should use? ' HA_LAT
read -p -r 'What is your GitHub username? ' GH_USER
read -p -r 'What should be the name of the project? ' PROJECT_NAME

if [ -z "$HA_IP" ];then HA_IP="127.0.0.1"; fi
if [ -z "$HA_LAT" ];then HA_LAT="XXXXXXXX"; fi
if [ -z "$GH_USER" ];then GH_USER="username"; fi
if [ -z "$PROJECT_NAME" ];then PROJECT_NAME="HelloWorld"; fi

git clone https://github.com/net-daemon/netdaemon-app-template.git /tmp/init
cp /tmp/init/_appsettings.json /tmp/init/appsettings.json

sed -i "s|localhost|${HA_IP}|" /tmp/init/appsettings.json
sed -i "s|enter_token_here|${HA_LAT}|" /tmp/init/appsettings.json

sed -i "s|namespace HelloWorld|namespace ${GH_USER}|" /tmp/init/apps/HelloWorld/HelloWorld.cs
sed -i "s|class HelloWorldApp|class ${PROJECT_NAME}App|" /tmp/init/apps/HelloWorld/HelloWorld.cs
sed -i "s|hello_world_app|${PROJECT_NAME,,}_app|" /tmp/init/apps/HelloWorld/HelloWorld.yaml
sed -i "s|HelloWorld.HelloWorldApp|${GH_USER}.${PROJECT_NAME}App|" /tmp/init/apps/HelloWorld/HelloWorld.yaml

mv /tmp/init/apps /tmp/init/tmp
mkdir -p /tmp/init/apps/"${PROJECT_NAME}"
mv /tmp/init/tmp/HelloWorld/HelloWorld.cs /tmp/init/apps/"${PROJECT_NAME}"/"${PROJECT_NAME}".cs
mv /tmp/init/tmp/HelloWorld/HelloWorld.yaml /tmp/init/apps/"${PROJECT_NAME}"/"${PROJECT_NAME}".yaml
rm -R /tmp/init/tmp

rm -R /tmp/init/.git
rm -R /tmp/init/.devcontainer
cp -a /tmp/init/. "$(GetWorkspaceName)"
cd "$(GetWorkspaceName)" || exit 1
git init