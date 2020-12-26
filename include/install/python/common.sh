#!/usr/bin/env bash
set -e
echo -e "\\033[0;34mRunning install script 'python/common.sh'\\033[0m"

PYTHON_VERSION="$1"
PYTHON_INSTALL_PATH="/usr/local/python"

echo -e "\\033[0;34mInstalling Python ${PYTHON_VERSION} to ${PYTHON_INSTALL_PATH}\\033[0m"

mkdir -p /tmp/python-src "${PYTHON_INSTALL_PATH}"
curl -sSLf -o /tmp/python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz"
tar -xJC "/tmp/python-src" --strip-components=1 -f /tmp/python.tar.xz

cd /tmp/python-src || exit 1
./configure \
    --prefix="${PYTHON_INSTALL_PATH}" \
    --enable-optimizations \
    --with-ensurepip=install

make -j"$(nproc)" EXTRA_CFLAGS="-DTHREAD_STACK_SIZE=0x100000"
make install

cd "${PYTHON_INSTALL_PATH}/bin" || exit 1
ln -s idle3 idle
ln -s pydoc3 pydoc
ln -s python3 python
ln -s pip3 pip
ln -s python3-config python-config

ls -la

rm -rf /tmp/python-dl.tgz /tmp/python-src
set -e

echo "Python version:"
python --version

echo "Python3 version:"
python3 --version

bash /include/cleanup/python.sh