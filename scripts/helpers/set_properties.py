from datetime import datetime
import os
from scripts.helpers.files import get_versions

versions = get_versions()
SHA = os.getenv("GITHUB_SHA")


def set_envs(container, tag):
    if container.get("env") is None:
        container["env"] = {}

    container["env"]["CONTAINER_TYPE"] = tag

    if "devcontainer" in container.get("features", []):
        container["env"]["DEVCONTAINER"] = "True"

    if "S6" in container.get("features", []):
        container["env"]["S6_BEHAVIOUR_IF_STAGE2_FAILS"] = "2"
        container["env"]["S6_CMD_WAIT_FOR_SERVICES"] = "1"
        container["env"]["S6_BEHAVIOUR_IF_STAGE2_FAILS"] = "2"

    return container


def set_labels(container):
    date = datetime.now()
    container["label"] = {
        "maintainer": "hi@ludeeus.dev",
        "build.date": f"{date.year}-{date.month}-{date.day}",
        "build.sha": SHA,
    }
    return container


def set_versions(tag):
    tag["base"] = f"{tag['base']}:{versions['base'][tag['base']]}"

    for package in list(tag.get("alpine-packages", [])):
        if package in versions["alpine"]:
            tag["alpine-packages"].remove(package)
            tag["alpine-packages"].append(f"{package}={versions['alpine'][package]}")
        else:
            exit(f"::error:: {package} not in versions file")

    for package in list(tag.get("python-packages", [])):
        if package in versions["python"]:
            tag["python-packages"].remove(package)
            tag["python-packages"].append(f"{package}=={versions['python'][package]}")
        else:
            exit(f"::error:: {package} not in versions file")

    return tag
