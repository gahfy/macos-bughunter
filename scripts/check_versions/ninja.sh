#!/bin/sh

ACTUAL_URL=`curl -sI https://github.com/ninja-build/ninja/releases/latest | grep -i 'Location: ' | cut -c 11- | tr -d '\r'`
EXPECTED_URL="https://github.com/ninja-build/ninja/releases/tag/v1.12.1"
if [[ "${ACTUAL_URL}" == "${EXPECTED_URL}" ]]; then
    printf "ninja 1.12.1: \e[32m✔ OK\e[0m\n"
else
    printf "ninja 1.12.1: \e[31m✘ Not OK\e[0m\n"
fi