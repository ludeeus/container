"""Parse github release for version."""
import requests
from version import Version
from jsonfile import JsonFile

VERSION_FILE = "./include/install/{folder}/versions.json"


def _github_release(repo):
    url = f"https://github.com/{repo}/releases/latest"
    response = requests.get(url).text
    return (
        response.split("octicon-tag")[1]
        .split("</span>")[0]
        .split(">")[-1]
        .replace("v", "")
    )


def update_with_github_release(
    name: str,
    file_section: str,
    repository: str,
    labels: str,
    include_install_folder: str | None = None,
):
    """Update version with a github release."""
    if not include_install_folder:
        include_install_folder = file_section

    version_file = JsonFile(VERSION_FILE.format(folder=include_install_folder))
    current = Version(version_file.read()[file_section])
    upstream = Version(_github_release(repository))

    if current == upstream:
        print(f"Nothing to do, both current and upstream is {current}")
        exit(0)

    version_file.update(file_section, upstream.string)

    with open("./commit", "w", encoding="UTF-8") as commit:
        commit.write(f"Update {name} from {current.string} to {upstream.string}")

    with open("./labels", "w", encoding="UTF-8") as labels_file:
        labels_file.write(labels)
