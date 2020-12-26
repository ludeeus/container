#!/usr/bin/env bash

echo -e "\\033[0;34mRunning cleanup script 'alpine.sh'\\033[0m"
apk del --no-cache .build-deps > /dev/null 2>&1
apk del --no-cache .fetch-deps > /dev/null 2>&1
rm -rf /var/cache/apk/*