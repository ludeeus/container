"""Update s6."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile
from github import github_release

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

install_s6_version = JsonFile("./include/install/s6/versions.json")

current = Version(install_s6_version.read()["s6"])
upstream = Version(github_release("just-containers/s6-overlay"))

if current.equals(upstream):
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)


install_s6_version.update("s6", upstream.string)

with open("./commit", "w") as commit:
    commit.write(f"Update GitHub CLI from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("S6")