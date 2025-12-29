#!/bin/sh

curl -s https://www.python.org/downloads/source/ | gunzip | grep 'Latest Python 3 Release - Python 3\.14\.2' > /dev/null

if [[ $? -eq 0 ]]; then
    printf "Python 3.14.2: \e[32m✔ OK\e[0m\n"
else
    printf "Python 3.14.2: \e[31m✘ Not OK\e[0m\n"
fi