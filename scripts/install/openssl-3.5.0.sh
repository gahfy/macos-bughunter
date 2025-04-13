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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz" \
    "39cc80e2843a2ee30f3f5de25cd9d0f759ad8de71b0b39f5a679afaaa74f4eb58d285ae50e29e4a27b139b49343ac91d1f05478f96fb0c6b150f16d7b634676f" \
    "openssl-${OPENSSL_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf openssl-${OPENSSL_VERSION}.tar.gz
mkdir openssl-build
cd openssl-build
../openssl-${OPENSSL_VERSION}/Configure --prefix=${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION}
make -j12
make -j12 test
make -j12 install

ln -s ${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION} ${INSTALL_DIR}/openssl
ln -s ${INSTALL_DIR}/mozilla-ca-cert/cert.pem ${BUILD_DIR}/${TEMP_PREFIX}openssl-${OPENSSL_VERSION}/ssl/cert.pem
cd ..
rm -rf openssl-build
rm -rf openssl-${OPENSSL_VERSION}