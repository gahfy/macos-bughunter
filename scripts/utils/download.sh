#!/bin/sh

# Usage : ./script.sh <url> <sha512> <filename>

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.sh

URL="$1"
EXPECTED_HASH="$2"
FILENAME="$3"
DEST_FILE="${SOURCES_DIR}/${FILENAME}"
MAX_ATTEMPTS=3

if [[ -f "${DEST_FILE}" ]]; then
    ACTUAL_HASH=$(sha512sum "${DEST_FILE}" | awk '{print $1}')
    if [[ "${ACTUAL_HASH}" == "${EXPECTED_HASH}" ]]; then
        echo "File already exists with the right hash. Nothing to do."
        exit 0
    else
        echo "File exists with the wrong hash, deleting it."
        rm -f "${DEST_FILE}"
    fi
fi

for attempt in $(seq 1 ${MAX_ATTEMPTS}); do
    echo "Downloading ${URL} (attempt ${attempt})"
    curl -L "$URL" -o "${DEST_FILE}"

    if [[ $? -eq 0 ]]; then
        ACTUAL_HASH=$(sha512sum "${DEST_FILE}" | awk '{print $1}')
        if [[ "${ACTUAL_HASH}" == "${EXPECTED_HASH}" ]]; then
            echo "Download successful."
            exit 0
        else
            echo "Hashes are not matching, trying again."
            rm -f "${DEST_FILE}"
        fi
    else
        echo "Download failes, trying again."
    fi
done

echo "Failed to download after ${MAX_ATTEMPTS} attempts."
exit 1