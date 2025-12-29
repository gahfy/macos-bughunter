#!/bin/sh

ACTUAL_URL=`curl -sI https://github.com/google/googletest/releases/latest | grep -i 'Location: ' | cut -c 11- | tr -d '\r'`
EXPECTED_URL="https://github.com/google/googletest/releases/tag/v1.17.0"
if [[ "${ACTUAL_URL}" == "${EXPECTED_URL}" ]]; then
    printf "GoogleTest 1.17.0: \e[32m✔ OK\e[0m\n"
else
    printf "GoogleTest 1.17.0: \e[31m✘ Not OK\e[0m\n"
fi