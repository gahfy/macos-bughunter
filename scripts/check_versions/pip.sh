#!/bin/sh

curl -s https://github.com/pypa/pip/tags | grep -m 1 '<a href="/pypa/pip/releases/tag/[^"]\+"' | grep '25\.3\"' > /dev/null
if [[ $? -eq 0 ]]; then
    printf "pip 25.3: \e[32m✔ OK\e[0m\n"
else
    printf "pip 25.3: \e[31m✘ Not OK\e[0m\n"
fi