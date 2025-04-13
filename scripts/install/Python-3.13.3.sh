#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh
source ${BUILD_DIR}/profile.sh

if [[ "${TEMP}" == "1" ]]; then
  TEMP_PREFIX="temp-"
else
  TEMP_PREFIX=""
fi

${SCRIPT_DIR}/../utils/download.sh "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz" \
    "f7559b6dceae69f48742af0a6497fbec42cd1e5304f64b6eb9d89222a1171ccf12fa186cc0decabb4e98d05223184967a4a7537754c01083dacdc9073cb1a578" \
    "Python-${PYTHON_VERSION}.tar.xz"

cd ${SOURCES_DIR}
tar -xf Python-${PYTHON_VERSION}.tar.xz
mkdir Python-build
cd Python-build
../Python-${PYTHON_VERSION}/configure \
    --with-openssl=${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION} \
    --prefix=${BUILD_DIR}/${TEMP_PREFIX}Python-${PYTHON_VERSION} \
    --with-ensurepip=no
make -j12
# test_signal is known to fail on macOS: https://github.com/python/cpython/issues/110017
make -j12 test TESTOPTS="-x test_signal"
make -j12 install

ln -s ${BUILD_DIR}/${TEMP_PREFIX}Python-${PYTHON_VERSION} ${INSTALL_DIR}/Python
cd ..
rm -rf Python-build
rm -rf Python-${PYTHON_VERSION}