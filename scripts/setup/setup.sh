#!/bin/sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../utils/constants.sh

mkdir -p ${SOURCES_DIR}
mkdir -p ${BUILD_DIR}
mkdir -p ${INSTALL_DIR}

echo "" > ${BUILD_DIR}/profile.sh
echo "for dir in "${INSTALL_DIR}"/*; do" >> ${BUILD_DIR}/profile.sh
echo '    if [[ -d "$dir" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '        if [[ -d "$dir/bin" ]]; then' >> ${BUILD_DIR}/profile.sh
echo '            if [[ ":$PATH:" != *":$dir/bin:"* ]]; then' >> ${BUILD_DIR}/profile.sh
echo '                export PATH="$dir/bin:$PATH"' >> ${BUILD_DIR}/profile.sh
echo '            fi' >> ${BUILD_DIR}/profile.sh
echo '        fi' >> ${BUILD_DIR}/profile.sh
echo '    fi' >> ${BUILD_DIR}/profile.sh
echo 'done' >> ${BUILD_DIR}/profile.sh

ZSHRC="$HOME/.zshrc"
LINE="source ${BUILD_DIR}/profile.sh"

if ! grep -Fxq "$LINE" "$ZSHRC"; then
    echo "$LINE" >> "$ZSHRC"
fi