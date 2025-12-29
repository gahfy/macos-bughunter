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

${SCRIPT_DIR}/../utils/download.sh "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/openmp-${LLVM_VERSION}.src.tar.xz" \
    "40ad2d57dc63fa11d4ff6655af4f6d55fa09439e4f634e5943a6c1180f856dc3bcb29bd3792d409e45f813988b295e3bf4819632d476238531b17f0cae5b01f0" \
    "openmp-${LLVM_VERSION}.src.tar.xz"

${SCRIPT_DIR}/../utils/download.sh "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/cmake-${LLVM_VERSION}.src.tar.xz" \
    "7b2a8c1792f0f2c2efb9f5813bc6acd287e782eac0438e9303791f7ceefe75fb6a49c55ea2e1a3d741b2ee935023f9273c79f9d7321250b5e659d14a05ef9e63" \
    "cmake-${LLVM_VERSION}.src.tar.xz"

cd ${SOURCES_DIR}
tar -xf cmake-${LLVM_VERSION}.src.tar.xz
tar -xf openmp-${LLVM_VERSION}.src.tar.xz
mkdir openmp-build
cd openmp-build
cp -R ../cmake-${LLVM_VERSION}.src ./cmake
cp -R ../openmp-${LLVM_VERSION}.src ./src
mkdir shared
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}openmp-${LLVM_VERSION} \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_MACOSX_RPATH=OFF \
    -DCMAKE_INSTALL_NAME_DIR=${BUILD_DIR}/${TEMP_PREFIX}openmp-${LLVM_VERSION}/lib \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DLIBOMP_INSTALL_ALIASES=OFF \
    -S ./src \
    -B ./shared
cmake  --build ./shared
cmake  --build ./shared --target install
cd ${SOURCES_DIR}
rm -rf openmp-build
mkdir openmp-build
cd openmp-build
cp -R ../cmake-${LLVM_VERSION}.src ./cmake
cp -R ../openmp-${LLVM_VERSION}.src ./src
mkdir static
cmake -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${TEMP_PREFIX}openmp-${LLVM_VERSION} \
    -DBUILD_SHARED_LIBS=OFF \
    -DLIBOMP_INSTALL_ALIASES=OFF \
    -DLIBOMP_ENABLE_SHARED=OFF \
    -S ./src \
    -B ./static
cmake  --build ./static
cmake  --build ./static --target install
ln -s ${BUILD_DIR}/${TEMP_PREFIX}openmp-${LLVM_VERSION} ${INSTALL_DIR}/openmp
cd ..
rm -rf openmp-build
rm -rf openmp-${LLVM_VERSION}.src
rm -rf cmake-${LLVM_VERSION}.src