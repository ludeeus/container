"""Update yarn."""
from github import update_with_github_release

update_with_github_release(
    "Yarn",
    "yarn",
    "yarnpkg/yarn",
    "node,debian/node,alpine/node",
    "node",
)
