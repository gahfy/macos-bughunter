#!/bin/sh

curl -s https://cmake.org/download/ | grep 'Latest Release (4\.0\.1)' > /dev/null

if [[ $? -eq 0 ]]; then
    printf "CMake 4.0.1: \e[32m✔ OK\e[0m\n"
else
    printf "CMake 4.0.1: \e[31m✘ Not OK\e[0m\n"
fi