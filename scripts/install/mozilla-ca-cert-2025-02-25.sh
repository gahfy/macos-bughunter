#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh

${SCRIPT_DIR}/../utils/download.sh "https://curl.se/ca/cacert-${MOZILLA_CA_CERT_VERSION}.pem" \
    "e5fe41820460e6b65e8cd463d1a5f01b7103e1ef66cb75fedc15ebcba3ba6600d77e5e7c2ab94cbb1f11c63b688026a04422bbe2d7a861f7a988f67522ffae3c" \
    "mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}.pem"

cd ${SOURCES_DIR}
mkdir ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}
cp mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}.pem ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}/cert.pem

ln -s ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION} ${INSTALL_DIR}/mozilla-ca-cert