#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'python/common.sh'\\033[0m"

PYTHON_VERSION="$1"

PYTHON_INSTALL_PATH="/usr/local/python${PYTHON_VERSION}"
GNU_ARCH="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"

echo -e "\\033[0;34mInstalling Python ${PYTHON_VERSION}\\033[0m"

mkdir -p /tmp/python-src "${PYTHON_INSTALL_PATH}"
curl -sSL -o /tmp/python.tgz "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
tar -xzf /tmp/python.tgz -C "/tmp/python-src" --strip-components=1

cd /tmp/python-src || exit 1
./configure \
    --prefix="${PYTHON_INSTALL_PATH}" \
    --build="$GNU_ARCH" \
    --enable-optimizations \
    --with-ensurepip=install

make -j "$(nproc)"

make install

ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3 /usr/bin/python
ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3 /usr/bin/python3
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pip3 /usr/bin/pip
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pip3 /usr/bin/pip3
ln -sf "${PYTHON_INSTALL_PATH}"/bin/idle3 /usr/bin/idle
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pydoc3 /usr/bin/pydoc
ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3-config /usr/bin/python-config

rm -rf /tmp/python-dl.tgz /tmp/python-src
bash /include/cleanup/python.sh

python --version
python3 --version