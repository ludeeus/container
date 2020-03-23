#!/bin/bash
# https://dotnet.microsoft.com/download/dotnet-core/3.1

ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/21a124fd-5bb7-403f-bdd2-489f9d21d695/b58fa90d19a5a5124d21dea94422868c/dotnet-sdk-3.1.200-linux-arm.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/30ed47bb-c25b-431c-9cfd-7b942b07314f/5c92af345a5475ca58b6878dd974e1dc/dotnet-runtime-3.1.2-linux-arm.tar.gz";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/781cb53b-046c-45fb-b18e-97ad65ff61a0/5c6ce7f4e031dad7cca0fdd5bcf4335b/dotnet-sdk-3.1.200-linux-arm64.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/ec985ae1-e15c-4858-b586-de5f78956573/f585f8ffc303bbca6a711ecd61417a40/aspnetcore-runtime-3.1.2-linux-arm64.tar.gz";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "https://download.visualstudio.microsoft.com/download/pr/2d72ee67-ac4d-42c6-97d9-a26a28201fc8/977ad14b99b6ed03dcefd6655789e43a/aspnetcore-runtime-3.1.2-linux-x64.tar.gz";
    wget -q -nv -O /tmp/sdk.tar.gz "https://download.visualstudio.microsoft.com/download/pr/daec2daf-b458-4ae1-9046-b8ba09b5fb49/733e2d73b41640d6e6bdf1cc6b9ef03b/dotnet-sdk-3.1.200-linux-x64.tar.gz";
fi
