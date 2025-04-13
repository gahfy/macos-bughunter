#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

${SCRIPT_DIR}/cmake.sh
${SCRIPT_DIR}/googletest.sh
${SCRIPT_DIR}/mozilla-ca-cert.sh
${SCRIPT_DIR}/ninja.sh
${SCRIPT_DIR}/openssl.sh
${SCRIPT_DIR}/pip.sh
${SCRIPT_DIR}/Python.sh