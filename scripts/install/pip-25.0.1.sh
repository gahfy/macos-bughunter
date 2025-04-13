#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh
source ${BUILD_DIR}/profile.sh

${SCRIPT_DIR}/../utils/download.sh "https://github.com/pypa/pip/archive/refs/tags/${PIP_VERSION}.tar.gz" \
    "a6850c8567082bbf98483a45e523c4de12132136d2b0aa388ac619c02ffd0c8f6aea7d727f7d84167dadec5f1e56dd478b2233b0caa5d9b3e5cadc9e1f3dc12c" \
    "pip-${PIP_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf pip-${PIP_VERSION}.tar.gz
cd pip-${PIP_VERSION}
PYTHONPATH=src python3 src/pip/__main__.py --version
PYTHONPATH=src python3 src/pip/__main__.py install . --prefix="${BUILD_DIR}/pip-${PIP_VERSION}"
ln -s ${BUILD_DIR}/pip-${PIP_VERSION} ${INSTALL_DIR}/pip
cd ..
rm -rf pip-${PIP_VERSION}