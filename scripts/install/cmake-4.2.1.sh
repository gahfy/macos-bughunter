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
    "75617692e975f5974bc015d62983e48d0dedaed2daa1e25d93807d25c6ed836e73e37de064e1e924078162fc20f38f9210ac1c4d699c9bd795050119abc848ce" \
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