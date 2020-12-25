#!/usr/bin/env bash

echo -e "\\033[0;34mRunning install script 'python/common.sh'\\033[0m"

PYTHON_VERSION="$1"

PYTHON_INSTALL_PATH="/usr/local/python${PYTHON_VERSION}"
GNU_ARCH="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"

echo -e "\\033[0;34mInstalling Python ${PYTHON_VERSION}\\033[0m"

mkdir -p /tmp/python-src "${PYTHON_INSTALL_PATH}"
curl -sSL -o /tmp/python.tgz "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
tar -xzf /tmp/python.tgz -C "/tmp/python-src" --strip-components=1

cd /tmp/python-src || exit
./configure \
    --prefix="${PYTHON_INSTALL_PATH}" \
    --build="$GNU_ARCH" \
    --enable-optimizations \
    --enable-shared \
    --with-lto \
    --with-system-expat \
    --with-system-ffi \
    --without-ensurepip

make -j "$(nproc)" \
  LDFLAGS="-Wl,--strip-all" \
  CFLAGS="-fno-semantic-interposition -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free" \
  EXTRA_CFLAGS="-DTHREAD_STACK_SIZE=0x100000"

make install

rm -rf /tmp/python-dl.tgz /tmp/python-src

ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3 /usr/bin/python
ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3 /usr/bin/python3
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pip3 /usr/bin/pip
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pip3 /usr/bin/pip3
ln -sf "${PYTHON_INSTALL_PATH}"/bin/idle3 /usr/bin/idle
ln -sf "${PYTHON_INSTALL_PATH}"/bin/pydoc3 /usr/bin/pydoc
ln -sf "${PYTHON_INSTALL_PATH}"/bin/python3-config /usr/bin/python-config

bash /include/cleanup/python.sh

python --version
python3 --version
