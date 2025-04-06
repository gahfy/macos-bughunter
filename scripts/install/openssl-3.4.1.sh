#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh

if [[ "${TEMP}" == "1" ]]; then
  TEMP_PREFIX="temp-"
else
  TEMP_PREFIX=""
fi

${SCRIPT_DIR}/../utils/download.sh "https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz" \
    "1de6307c587686711f05d1e96731c43526fa3af51e4cd94c06c880954b67f6eb4c7db3177f0ea5937d41bc1f8cadcf5bce75025b5c1a46a469376960f1001c5f" \
    "openssl-${OPENSSL_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf openssl-${OPENSSL_VERSION}.tar.gz
mkdir openssl-build
cd openssl-build
../openssl-${OPENSSL_VERSION}/Configure --prefix=${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION}
make
make test
make install

ln -s ${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION} ${INSTALL_DIR}/openssl
ln -s ${INSTALL_DIR}/mozilla-ca-cert/cert.pem ${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION}/ssl/cert.pem
cd ..
rm -rf openssl-build
rm -rf openssl-${OPENSSL_VERSION}