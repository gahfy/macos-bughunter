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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/google/googletest/releases/download/v${GOOGLETEST_VERSION}/googletest-${GOOGLETEST_VERSION}.tar.gz" \
    "bec8dad2a5abbea8e9e5f0ceedd8c9dbdb8939e9f74785476b0948f21f5db5901018157e78387e106c6717326558d6642fc0e39379c62af57bf1205a9df8a18b" \
    "googletest-${GOOGLETEST_VERSION}.tar.gz"

cd ${SOURCES_DIR}
tar -xzf googletest-${GOOGLETEST_VERSION}.tar.gz
mkdir googletest-build
cd googletest-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}googletest-${GOOGLETEST_VERSION} \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_MACOSX_RPATH=OFF \
    -DCMAKE_INSTALL_NAME_DIR=${BUILD_DIR}/${TEMP_PREFIX}googletest-${GOOGLETEST_VERSION}/lib \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    ../googletest-${GOOGLETEST_VERSION}
cmake  --build .
cmake  --build . --target install
cd ${SOURCES_DIR}
rm -rf googletest-build
mkdir googletest-build
cd googletest-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}googletest-${GOOGLETEST_VERSION} \
    -DBUILD_SHARED_LIBS=OFF \
    ../googletest-${GOOGLETEST_VERSION}
cmake  --build .
mv ./lib/*.a ${BUILD_DIR}/${TEMP_PREFIX}googletest-${GOOGLETEST_VERSION}/lib/
ln -s ${BUILD_DIR}/${TEMP_PREFIX}googletest-${GOOGLETEST_VERSION} ${INSTALL_DIR}/googletest
cd ..
rm -rf googletest-build
rm -rf googletest-${GOOGLETEST_VERSION}