#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh

${SCRIPT_DIR}/../setup/setup.sh
${SCRIPT_DIR}/mozilla-ca-cert-${MOZILLA_CA_CERT_VERSION}.sh
TEMP=1 ${SCRIPT_DIR}/openssl-${OPENSSL_VERSION}.sh