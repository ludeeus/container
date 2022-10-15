"""Update image."""
from typing import Callable
import requests

from version import Version
from jsonfile import JsonFile

URL = (
    "https://registry.hub.docker.com/v2/repositories/library/{image}/tags?page_size=100"
)
BASE_CONFIG_FILE = "./containerfiles/{image}/base/config.json"
S6_BASE_CONFIG_FILE = "./containerfiles/{image}-s6/base/config.json"
NODE_CONFIG_FILE = "./containerfiles/{image}/node/config.json"
PYTHON_CONFIG_FILE = "./containerfiles/{image}/python/config.json"


def _get_all_tags(
    image: str,
    should_use_tag: Callable[[Version], bool],
    filter_tag_name: str | None = None,
) -> list[Version]:
    """Get all tags from api."""
    tags = []
    url = URL.format(image=image)
    if filter_tag_name:
        url += f"&name={filter_tag_name}"

    while url:

        request = requests.get(url).json()
        for entry in request["results"]:
            name = entry["name"]
            if name[0].isdigit() and "." in name:
                version = Version(name)
                if should_use_tag(version):
                    tags.append(version)

        url = request.get("next", None)

    return sorted(tags)


def update_image(
    image: str,
    should_use_tag: Callable[[Version], bool],
    filter_tag_name: str | None = None,
) -> None:
    """Update given image."""
    base_config = JsonFile(BASE_CONFIG_FILE.format(image=image))
    s6_base_config = JsonFile(S6_BASE_CONFIG_FILE.format(image=image))
    node_config = JsonFile(NODE_CONFIG_FILE.format(image=image))
    python_config = JsonFile(PYTHON_CONFIG_FILE.format(image=image))
    current = Version(base_config.read()["args"]["BUILD_FROM_TAG"])

    tags = _get_all_tags(image, should_use_tag, filter_tag_name)
    upstream = tags.pop()

    if current == upstream:
        print(f"Nothing to do, both current and upstream is {current}")
        exit(0)

    base_config.update("args.BUILD_FROM_TAG", upstream.string)
    base_config.update("tags", upstream.tags)
    base_config_tag = upstream.tags[-1]

    node_config.update("args.BUILD_FROM_TAG", base_config_tag)
    python_config.update("args.BUILD_FROM_TAG", base_config_tag)
    s6_base_config.update("args.BUILD_FROM_TAG", base_config_tag)
    s6_base_config.update("tags", upstream.tags)

    with open("./commit", "w", encoding="UTF-8") as commit:
        commit.write(f"Update {image} from {current.string} to {upstream.string}")

    with open("./labels", "w", encoding="UTF-8") as labels:
        labels.write(f"{image}/base")
