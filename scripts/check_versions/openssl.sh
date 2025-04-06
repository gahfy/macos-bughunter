#!/bin/sh

ACTUAL_URL=`curl -sI https://github.com/openssl/openssl/releases/latest | grep -i 'Location: ' | cut -c 11- | tr -d '\r'`
EXPECTED_URL="https://github.com/openssl/openssl/releases/tag/openssl-3.4.1"
if [[ "${ACTUAL_URL}" == "${EXPECTED_URL}" ]]; then
    printf "OpenSSL 3.4.1: \e[32m✔ OK\e[0m\n"
else
    printf "OpenSSL 3.4.1: \e[31m✘ Not OK\e[0m\n"
fi