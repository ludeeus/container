import requests
from scripts.helpers.github import get_release_from_github
from scripts.helpers.files import save_versions, get_versions


def update_s6():
    installfile = "rootfs/s6/install"
    current = get_release_from_github("just-containers/s6-overlay")
    with open(installfile, "r") as install:
        content = install.read()
    installed = content.split('="')[1].split('"\n')[0]
    if current != installed:
        content = content.replace(installed, current)
        with open(installfile, "w") as install:
            install.write(content)
        versions = get_versions()
        versions["special"]["S6"] = current
        save_versions(versions)


def update_netcore():
    baseurl = "https://dotnet.microsoft.com"
    dotnet = {
        "arm": {"sdk": None, "runtime": None},
        "arm64": {"sdk": None, "runtime": None},
        "amd64": {"sdk": None, "runtime": None},
    }

    url = f"{baseurl}/download/dotnet-core/3.1"
    request = requests.get(url).text

    for line in request.split("\n"):
        if (
            "ARM32" in line
            and "linux" in line
            and "sdk" in line
            and dotnet["arm"]["sdk"] is None
        ):
            dotnet["arm"]["sdk"] = line.split('"')[1]
        if (
            "ARM32" in line
            and "linux" in line
            and "runtime" in line
            and dotnet["arm"]["runtime"] is None
            and "aspnetcore" not in line
        ):
            dotnet["arm"]["runtime"] = line.split('"')[1]

        if (
            "ARM64" in line
            and "linux" in line
            and "sdk" in line
            and dotnet["arm64"]["sdk"] is None
        ):
            dotnet["arm64"]["sdk"] = line.split('"')[1]
        if (
            "ARM64" in line
            and "linux" in line
            and "runtime" in line
            and dotnet["arm64"]["runtime"] is None
            and "aspnetcore" not in line
        ):
            dotnet["arm64"]["runtime"] = line.split('"')[1]

        if (
            "x64" in line
            and "rhel" not in line
            and "alpine" not in line
            and "linux" in line
            and "sdk" in line
            and dotnet["amd64"]["sdk"] is None
            and "aspnetcore" not in line
        ):
            dotnet["amd64"]["sdk"] = line.split('"')[1]
        if (
            "x64" in line
            and "rhel" not in line
            and "alpine" not in line
            and "linux" in line
            and "runtime" in line
            and dotnet["amd64"]["runtime"] is None
        ):
            dotnet["amd64"]["runtime"] = line.split('"')[1]

    for arch in dotnet:
        if dotnet[arch]["sdk"] is None or dotnet[arch]["runtime"] is None:
            continue
        request = requests.get(f"{baseurl}{dotnet[arch]['sdk']}").text
        for line in request.split("\n"):
            if "window.open" in line:
                dotnet[arch]["sdk"] = line.split('"')[1]
                break
        request = requests.get(f"{baseurl}{dotnet[arch]['runtime']}").text
        for line in request.split("\n"):
            if "window.open" in line:
                dotnet[arch]["runtime"] = line.split('"')[1]
                break

    with open("rootfs/dotnet-base/build_scripts/install", "r") as dnfile:
        content = dnfile.read()

    newcontent = f"""#!/bin/bash
# https://dotnet.microsoft.com/download/dotnet-core/3.1

ARCH=$(uname -m)

if [ "$ARCH" == "armv7l" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "{dotnet["arm"]["runtime"]}";
    wget -q -nv -O /tmp/sdk.tar.gz "{dotnet["arm"]["sdk"]}";
elif [ "$ARCH" == "aarch64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "{dotnet["arm64"]["runtime"]}";
    wget -q -nv -O /tmp/sdk.tar.gz "{dotnet["arm64"]["sdk"]}";
elif [ "$ARCH" == "x86_64" ]; then
    wget -q -nv -O /tmp/runtime.tar.gz "{dotnet["amd64"]["runtime"]}";
    wget -q -nv -O /tmp/sdk.tar.gz "{dotnet["amd64"]["sdk"]}";
fi
"""
    if newcontent != content:
        with open("rootfs/dotnet-base/build_scripts/install", "w") as dnfile:
            dnfile.write(newcontent)
        versions = get_versions()
        versions["special"]["dotnetcore-runtime"] = (
            dotnet["arm64"]["runtime"].split("-runtime-")[1].split("-linux")[0]
        )
        versions["special"]["dotnetcore-sdk"] = (
            dotnet["arm64"]["sdk"].split("-sdk-")[1].split("-linux")[0]
        )
        save_versions(versions)
