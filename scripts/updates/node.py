"""Update node."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile

URL = "https://nodejs.org/en/"

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

install_node_version = JsonFile("./include/install/node/versions.json")
alpine_node_config = JsonFile("./containerfiles/alpine/node/config.json")
alpine_s6_node_config = JsonFile("./containerfiles/alpine-s6/node/config.json")
debian_node_config = JsonFile("./containerfiles/debian/node/config.json")
debian_s6_node_config = JsonFile("./containerfiles/debian-s6/node/config.json")
devcontainer_node_config = JsonFile("./containerfiles/devcontainer/node/config.json")
devcontainer_frontend_config = JsonFile(
    "./containerfiles/devcontainer/frontend/config.json"
)

current = Version(install_node_version.read()["node"])

request = requests.get(URL).text
upstream = Version(request.split(" Current")[0].split("Download ")[-1])

if current.equals(upstream):
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)


install_node_version.update("node", upstream.string)

alpine_node_config.update("tags", upstream.tags)
alpine_s6_node_config.update("tags", upstream.tags)
alpine_s6_node_config.update("args.BUILD_FROM_TAG", upstream.string)

debian_node_config.update("tags", upstream.tags)
debian_s6_node_config.update("tags", upstream.tags)
debian_s6_node_config.update("args.BUILD_FROM_TAG", upstream.string)

devcontainer_node_config.update("args.BUILD_FROM_TAG", upstream.string)
devcontainer_node_config.update("tags", upstream.tags)
devcontainer_frontend_config.update("args.BUILD_FROM_TAG", upstream.string)

with open("./commit", "w") as commit:
    commit.write(f"Update NodeJS from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("node,debian/node,alpine/node")