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
    "d6e6f0e89a4844a69069ff0c7cefc07704a41c7b0c062a57534de87decdde63e27928147b321111b806aa7efa1061f031a1319b074391db61b0cbdccf096954c" \
    "ninja-${NINJA_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf ninja-${NINJA_VERSION}.tar.gz
mkdir ninja-build
cd ninja-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}ninja-${NINJA_VERSION} \
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