#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh
source ${BUILD_DIR}/profile.sh

${SCRIPT_DIR}/../utils/download.sh "https://github.com/pypa/pip/archive/refs/tags/${PIP_VERSION}.tar.gz" \
    "f50db092213ec3bb819d3da5669f73d119b5ec7f7ac5e8a587a17c27eafa32bc17a057df09389c526a3769ef3577f5553187d54ceffa89aed63f4b4498ff044e" \
    "pip-${PIP_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf pip-${PIP_VERSION}.tar.gz
cd pip-${PIP_VERSION}
PYTHONPATH=src python3 src/pip/__main__.py --version
PYTHONPATH=src python3 src/pip/__main__.py install . --prefix="${BUILD_DIR}/pip-${PIP_VERSION}"
ln -s ${BUILD_DIR}/pip-${PIP_VERSION} ${INSTALL_DIR}/pip
cd ..
rm -rf pip-${PIP_VERSION}