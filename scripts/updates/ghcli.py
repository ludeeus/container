"""Update yarn."""
from typing import TYPE_CHECKING
import requests

from version import Version
from jsonfile import JsonFile
from github import github_release

if TYPE_CHECKING:
    from .version import Version
    from .jsonfile import JsonFile

install_ghcli_version = JsonFile("./include/install/ghcli/versions.json")

current = Version(install_ghcli_version.read()["ghcli"])
upstream = Version(github_release("cli/cli"))
upstream = Version("1.4.1")

if current.equals(upstream):
    print(f"Nothing to do, both current and upstream is {current}")
    exit(0)


install_ghcli_version.update("ghcli", upstream.string)

with open("./commit", "w") as commit:
    commit.write(f"Update GitHub CLI from {current.string} to {upstream.string}")

with open("./labels", "w") as labels:
    labels.write("devcontainer")