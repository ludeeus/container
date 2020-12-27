"""Parse github release for version."""
import requests


def github_release(repo):
    url = f"https://github.com/{repo}/releases/latest"
    response = requests.get(url).text
    return (
        response.split("octicon-tag")[1]
        .split("</span>")[0]
        .split(">")[-1]
        .replace("v", "")
    )
