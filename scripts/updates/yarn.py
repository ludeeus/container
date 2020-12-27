"""Update yarn."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile
from github import github_release

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

install_yarn_version = JsonFile("./include/install/node/versions.json")

current = Version(install_yarn_version.read()["yarn"])
upstream = Version(github_release("yarnpkg/yarn"))

if current.equals(upstream):
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)


install_yarn_version.update("yarn", upstream.string)

with open("./commit", "w") as commit:
    commit.write(f"Update Yarn from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("node,debian/node,alpine/node")