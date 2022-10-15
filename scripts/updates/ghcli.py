"""Update ghcli."""
from github import update_with_github_release

update_with_github_release(
    "GitHub CLI",
    "ghcli",
    "cli/cli",
    "devcontainer",
)
