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
        "org.opencontainers.image.authors": "Ludeeus <hi@ludeeus.dev>",
        "org.opencontainers.image.created": date.isoformat(),
        "org.opencontainers.image.description": f"{container.get('description')}",
        "org.opencontainers.image.documentation": f"https://ludeeus.github.io/container/tags/{container['name']}",
        "org.opencontainers.image.licenses": "MIT",
        "org.opencontainers.image.revision": SHA,
        "org.opencontainers.image.source": "https://github.com/ludeeus/container",
        "org.opencontainers.image.title": f"{container['name'].title()}",
        "org.opencontainers.image.url": f"https://ludeeus.github.io/container/tags/{container['name']}",
        "org.opencontainers.image.vendor": "Ludeeus",
        "org.opencontainers.image.version": SHA
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
