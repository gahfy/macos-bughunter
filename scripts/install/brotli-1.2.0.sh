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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/google/brotli/archive/refs/tags/v${BROTLI_VERSION}.tar.gz" \
    "f94542afd2ecd96cc41fd21a805a3da314281ae558c10650f3e6d9ca732b8425bba8fde312823f0a564c7de3993bdaab5b43378edab65ebb798cefb6fd702256" \
    "brotli-${BROTLI_VERSION}.tar.gz"
cd ${SOURCES_DIR}
tar -xzf brotli-${BROTLI_VERSION}.tar.gz
mkdir brotli-build
cd brotli-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}brotli-${BROTLI_VERSION} \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_MACOSX_RPATH=OFF \
    -DCMAKE_INSTALL_NAME_DIR=${BUILD_DIR}/${TEMP_PREFIX}brotli-${BROTLI_VERSION}/lib \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    ../brotli-${BROTLI_VERSION}
cmake  --build .
cmake  --build . --target test
cmake  --build . --target install
cd ${SOURCES_DIR}
rm -rf brotli-build
mkdir brotli-build
cd brotli-build
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}googletest-${BROTLI_VERSION} \
    -DBUILD_SHARED_LIBS=OFF \
    ../brotli-${BROTLI_VERSION}
cmake  --build .
cmake  --build . --target test
mv ./*.a ${BUILD_DIR}/${TEMP_PREFIX}brotli-${BROTLI_VERSION}/lib/
ln -s ${BUILD_DIR}/${TEMP_PREFIX}brotli-${BROTLI_VERSION} ${INSTALL_DIR}/brotli
cd ..
rm -rf brotli-build
rm -rf brotli-${BROTLI_VERSION}