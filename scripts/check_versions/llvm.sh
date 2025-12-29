#!/bin/sh

ACTUAL_URL=`curl -sI https://github.com/llvm/llvm-project/releases/latest | grep -i 'Location: ' | cut -c 11- | tr -d '\r'`
EXPECTED_URL="https://github.com/llvm/llvm-project/releases/tag/llvmorg-21.1.8"
if [[ "${ACTUAL_URL}" == "${EXPECTED_URL}" ]]; then
    printf "LLVM 21.1.8: \e[32m✔ OK\e[0m\n"
else
    printf "LLVM 21.1.8: \e[31m✘ Not OK\e[0m\n"
fi