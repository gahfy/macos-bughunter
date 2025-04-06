#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

${SCRIPT_DIR}/mozilla-ca-cert.sh
${SCRIPT_DIR}/openssl.sh