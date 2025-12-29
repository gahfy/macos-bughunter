#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh
source ${BUILD_DIR}/profile.sh

${SCRIPT_DIR}/../utils/download.sh "https://curl.se/ca/cacert-${MOZILLA_CA_CERT_VERSION}.pem" \
    "aef293e084ef15a55a4f9dee395ee4bbbadea1f5a49c0590e0ff67a0630b5298d2bc79699ab95d70be0d2d06f9f1e55fe676b3e1d5ff912df88f2d6bff0d5736" \
    "mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}.pem"

cd ${SOURCES_DIR}
mkdir ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}
cp mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}.pem ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}/cert.pem

ln -s ${BUILD_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION} ${INSTALL_DIR}/mozilla-ca-cert