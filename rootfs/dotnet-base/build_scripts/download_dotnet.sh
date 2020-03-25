#!/bin/bash
# https://dotnet.microsoft.com/download/dotnet-core/3.1

ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/b68cde83-05c7-4421-ad9a-3e6f2cc53824/876dbfc9b4521d3ca89a226c6438ffc1/aspnetcore-runtime-3.1.3-linux-arm.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/ccbcbf70-9911-40b1-a8cf-e018a13e720e/03c0621c6510f9c6f4cca6951f2cc1a4/dotnet-sdk-3.1.201-linux-arm.tar.gz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/d5c6e9d7-25b9-47ac-9d67-35ac65211ad3/c8f4ccd0dc02ca8229ba43ecbe84294b/aspnetcore-runtime-3.1.3-linux-arm64.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/98a2e556-bedd-46c8-b3fa-96a9f1eb9556/09f60d50e3cbba0aa16d48ceec9dcb0b/dotnet-sdk-3.1.201-linux-arm64.tar.gz";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/7faca87b-7526-4dcd-ae23-4559d2c51ce3/7db1f314c733191ea43e1757e3b2583d/aspnetcore-runtime-3.1.3-linux-x64.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/f65a8eb0-4537-4e69-8ff3-1a80a80d9341/cc0ca9ff8b9634f3d9780ec5915c1c66/dotnet-sdk-3.1.201-linux-x64.tar.gz";
fi
