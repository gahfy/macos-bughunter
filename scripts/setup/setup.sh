#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh

mkdir -p ${SOURCES_DIR}
mkdir -p ${BUILD_DIR}
mkdir -p ${INSTALL_DIR}

echo "" > ${BUILD_DIR}/profile.sh
echo 'PYTHON_INSTALLED_VERSION=$(python3 -c "import sys; print(f'"'"'{sys.version_info.major}.{sys.version_info.minor}'"'"')")' >> ${BUILD_DIR}/profile.sh
echo "for dir in "${INSTALL_DIR}"/*; do" >> ${BUILD_DIR}/profile.sh
echo '    if [[ -d "$dir" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '        if [[ -d "$dir/bin" ]]; then' >> ${BUILD_DIR}/profile.sh
# Revert when final (this is not compatible with Visual Studio Code)
#echo '            if [[ ":$PATH:" != *":$dir/bin:"* ]]; then' >> ${BUILD_DIR}/profile.sh
echo '                export PATH="$dir/bin:$PATH"' >> ${BUILD_DIR}/profile.sh
#echo '            fi' >> ${BUILD_DIR}/profile.sh
echo '        fi' >> ${BUILD_DIR}/profile.sh
echo '        if [[ -d "$dir/lib" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '            if [[ -d "$dir/lib/python$PYTHON_INSTALLED_VERSION" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '                if [[ -d "$dir/lib/python$PYTHON_INSTALLED_VERSION/site-packages" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '                    if [[ ":$PYTHONPATH:" != *":$dir/lib/python$PYTHON_INSTALLED_VERSION/site-packages:"* ]]; then' >> ${BUILD_DIR}/profile.sh
echo '                        export PYTHONPATH="$dir/lib/python$PYTHON_INSTALLED_VERSION/site-packages:$PYTHONPATH"' >> ${BUILD_DIR}/profile.sh
echo '                    fi' >> ${BUILD_DIR}/profile.sh
echo '                fi' >> ${BUILD_DIR}/profile.sh
echo '            fi' >> ${BUILD_DIR}/profile.sh
echo '        fi' >> ${BUILD_DIR}/profile.sh
echo '    fi' >> ${BUILD_DIR}/profile.sh
echo 'done' >> ${BUILD_DIR}/profile.sh

ZPROFILE="$HOME/.zprofile"
LINE="source ${BUILD_DIR}/profile.sh"

if ! grep -Fxq "$LINE" "$ZPROFILE"; then
    echo "$LINE" >> "$ZPROFILE"
fi