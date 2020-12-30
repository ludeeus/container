"""Update debian."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile

URL = "https://registry.hub.docker.com/v1/repositories/library/debian/tags"
skip = ["3.9", "3.9.6", "edge", "latest"]

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

debian_base_config = JsonFile("./containerfiles/debian/base/config.json")
debian_s6_base_config = JsonFile("./containerfiles/debian-s6/base/config.json")
debian_node_config = JsonFile("./containerfiles/debian/node/config.json")
debian_python_config = JsonFile("./containerfiles/debian/python/config.json")

current = Version(debian_base_config.read()["args"]["BUILD_FROM_TAG"].split("-")[0])

request = requests.get(URL).json()
tags = [
    x["name"]
    for x in request
    if x["name"][0].isdigit()
    and x["name"] not in skip
    and "." in x["name"]
    and "-slim" in x["name"]
    and int(x["name"].split(".")[0]) >= 10
]

upstream = Version(tags.pop().split("-")[0])

if current == upstream:
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)

debian_base_config.update("args.BUILD_FROM_TAG", f"{upstream.string}-slim")
debian_base_config.update("tags", upstream.tags)

debian_node_config.update("args.BUILD_FROM_TAG", upstream.string)
debian_python_config.update("args.BUILD_FROM_TAG", upstream.string)
debian_s6_base_config.update("args.BUILD_FROM_TAG", upstream.string)
debian_s6_base_config.update("tags", upstream.tags)

with open("./commit", "w") as commit:
    commit.write(f"Update Debian from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("debian/base")