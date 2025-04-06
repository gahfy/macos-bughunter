#!/bin/sh

curl -s https://curl.se/docs/caextract.html | grep 'This bundle was generated at <b> Tue Feb 25 04:12:03 2025 GMT </b>.' > /dev/null

if [[ $? -eq 0 ]]; then
    printf "Mozilla CA 2025-02-25: \e[32m✔ OK\e[0m\n"
else
    printf "OpenSSL CA-2025-02-25: \e[31m✘ Not OK\e[0m\n"
fi