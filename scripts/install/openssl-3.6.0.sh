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
    "866825a1cdf0b705b409402fbc7a713e7d9b8e7736c5126be57b354927954c148a341fc52b02c0629c1e015a889bfd40217f8e703b73235892e91da060909b76" \
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