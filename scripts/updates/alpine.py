"""Update alpine."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile

URL = "https://registry.hub.docker.com/v2/repositories/library/alpine/tags"
skip = ["3.9", "3.9.6", "edge", "latest"]

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

alpine_base_config = JsonFile("./containerfiles/alpine/base/config.json")
alpine_s6_base_config = JsonFile("./containerfiles/alpine-s6/base/config.json")
alpine_node_config = JsonFile("./containerfiles/alpine/node/config.json")
alpine_python_config = JsonFile("./containerfiles/alpine/python/config.json")

current = Version(alpine_base_config.read()["args"]["BUILD_FROM_TAG"])

request = requests.get(URL).json()
tags = sorted(
    [
        x["name"]
        for x in request["results"]
        if x["name"][0].isdigit() and x["name"] not in skip and "." in x["name"]
    ]
)

upstream = Version(tags.pop())

if current.equals(upstream):
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)

alpine_base_config.update("args.BUILD_FROM_TAG", upstream.string)
alpine_base_config.update("tags", upstream.tags)

alpine_node_config.update("args.BUILD_FROM_TAG", upstream.string)
alpine_python_config.update("args.BUILD_FROM_TAG", upstream.string)
alpine_s6_base_config.update("args.BUILD_FROM_TAG", upstream.string)
alpine_s6_base_config.update("tags", upstream.tags)

with open("./commit", "w") as commit:
    commit.write(f"Update Alpine from {current.string} to {upstream.string}")