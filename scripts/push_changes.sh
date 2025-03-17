#!/bin/bash

echo "[*] Current directory: '$(pwd)'"
echo "[*] Directory listing:"
ls -laRI .git*

echo "[*] Configuring credentials"
git config --global user.name 'IpRangeBot'
git config --global user.email 'IpRangeBot@users.noreply.github.com'

if [[ `git status --porcelain` ]]; then
        echo "[*] Changes detected, pushing fresh data"
else
        echo "[+] No changes were detected, skipping push"
        exit 0
fi

git add --all
DATETIME=$(date "+%d-%m-%Y %T%z"); git commit -m "Automatic range refresh - $DATETIME"
git push
