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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz" \
    "c0b401b4db91a2eea01a474ee979b2c6f1daa97b4c8d1f856871ce5f6d567c4b26d6246bc57e2a5f914329302abcd9c00ab0d4394a25f2ad502b6b00a07903d2" \
    "ninja-${NINJA_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf ninja-${NINJA_VERSION}.tar.gz
mkdir ninja-build
cd ninja-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}ninja-${NINJA_VERSION} \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DGTest_DIR=${INSTALL_DIR}/googletest \
    -DGMOCK_LIBRARY=${INSTALL_DIR}/googletest/lib/libgmock.dylib \
    -DGMOCK_MAIN_LIBRARY=${INSTALL_DIR}/googletest/lib/libgmock_main.dylib \
    -DGTEST_INCLUDE_DIR=${INSTALL_DIR}/googletest/include \
    -DGTEST_LIBRARY=${INSTALL_DIR}/googletest/lib/libgtest.dylib \
    -DGTEST_MAIN_LIBRARY=${INSTALL_DIR}/googletest/lib/libgtest_main.dylib \
    ../ninja-${NINJA_VERSION}
cmake  --build .
cmake  --build . --target test
cmake  --build . --target install
ln -s ${BUILD_DIR}/${TEMP_PREFIX}ninja-${NINJA_VERSION} ${INSTALL_DIR}/ninja
cd ..
rm -rf ninja-build
rm -rf ninja-${NINJA_VERSION}