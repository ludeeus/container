"""Update python."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile

URL = "https://www.python.org/downloads"

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

install_python_version = JsonFile("./include/install/python/versions.json")
alpine_python_config = JsonFile("./containerfiles/alpine/python/config.json")
alpine_s6_python_config = JsonFile("./containerfiles/alpine-s6/python/config.json")
debian_python_config = JsonFile("./containerfiles/debian/python/config.json")
debian_s6_python_config = JsonFile("./containerfiles/debian-s6/python/config.json")
devcontainer_integration = JsonFile(
    "./containerfiles/devcontainer/integration/config.json"
)
devcontainer_python = JsonFile("./containerfiles/devcontainer/python/config.json")

current = Version(install_python_version.read()["python"])

request = requests.get(URL).text
upstream = Version(request.split(">Download Python ")[2].split("<")[0])

if current == upstream:
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)

install_python_version.update("python", upstream.string)
alpine_python_config.update("tags", upstream.tags)
alpine_s6_python_config.update("tags", upstream.tags)
alpine_s6_python_config.update("args.BUILD_FROM_TAG", upstream.string)
debian_python_config.update("tags", upstream.tags)
debian_s6_python_config.update("tags", upstream.tags)
debian_s6_python_config.update("args.BUILD_FROM_TAG", upstream.string)
devcontainer_integration.update("args.BUILD_FROM_TAG", upstream.string)
devcontainer_integration.update(
    "tags", ["latest", *[f"python-{tag}" for tag in upstream.tags if tag != "latest"]]
)
devcontainer_python.update("args.BUILD_FROM_TAG", upstream.string)
devcontainer_python.update("tags", upstream.tags)

with open("./commit", "w") as commit:
    commit.write(f"Update Python from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("python,debian/python,alpine/python")
