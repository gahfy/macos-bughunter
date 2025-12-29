#!/bin/sh

curl -s https://curl.se/docs/caextract.html | grep 'This bundle was generated at <b> Tue Dec 2 04:12:02 2025 GMT </b>\.' > /dev/null

if [[ $? -eq 0 ]]; then
    printf "Mozilla CA 2025-12-02: \e[32m✔ OK\e[0m\n"
else
    printf "OpenSSL CA-2025-12-02: \e[31m✘ Not OK\e[0m\n"
fi