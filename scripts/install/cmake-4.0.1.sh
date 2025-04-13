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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz" \
    "25f3e93b1fe09b4aacf6f6361942f829c4833075a05ad26a9bdbd1278f5f6a78389e619e478152e2ecc4108a4bccc3ed901f96db0571dc05f1feba4e04f8f516" \
    "cmake-${CMAKE_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf cmake-${CMAKE_VERSION}.tar.gz
mkdir cmake-build
cd cmake-build
../cmake-${CMAKE_VERSION}/bootstrap \
    --parallel=12 \
    --prefix=${BUILD_DIR}/${TEMP_PREFIX}cmake-${CMAKE_VERSION}
make -j12
make -j12 test
make -j12 install

ln -s ${BUILD_DIR}/${TEMP_PREFIX}cmake-${CMAKE_VERSION} ${INSTALL_DIR}/cmake
cd ..
rm -rf cmake-build
rm -rf cmake-${CMAKE_VERSION}