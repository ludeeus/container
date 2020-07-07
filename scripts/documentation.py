from sys import version
from scripts.build.instructions import load_instructions
from scripts.build.context import create_context
from scripts.helpers.files import get_instruction_files, get_versions
from scripts.build.dockerfile import generate_dockerfile

INSTRUCTIONS = {}
NEWLINE = ""

DOCKERFILE = """
***
<details>
<summary>Dockerfile</summary>

```dockerfile
{}
```
</details>
"""


def generate_documentation():
    versions = get_versions()
    content = []
    content.append("# ludeeus/container")
    content.append(NEWLINE)
    content.append(
        "Click on the tag name below to see the documentation for a specific tag:"
    )
    content.append(NEWLINE)

    for tag in sorted(INSTRUCTIONS):
        content.append(f"[{tag}](./tags/{tag})  ")

    with open("./docs/index.md", "w") as fp:
        fp.write("\n".join(content))

    for tag in INSTRUCTIONS:
        filename = f"./docs/tags/{tag}.md"

        content = []
        envs = {}
        alpinepackages = []
        debianpackages = []
        pythonpackages = []

        for env in INSTRUCTIONS[tag].get("env", []):
            envs[env] = INSTRUCTIONS[tag]["env"][env]

        for package in INSTRUCTIONS[tag].get("alpine-packages", []):
            alpinepackages.append(package)

        for package in INSTRUCTIONS[tag].get("debian-packages", []):
            debianpackages.append(package)

        for package in INSTRUCTIONS[tag].get("python-packages", []):
            pythonpackages.append(package)

        content.append(f"# {tag}")
        content.append(NEWLINE)

        content.append("[Back to overview](../index.md)")
        content.append(NEWLINE)

        if INSTRUCTIONS[tag].get("description"):
            content.append(f"_{INSTRUCTIONS[tag]['description']}_")
            content.append(NEWLINE)

        content.append(f"**Base image**: `{INSTRUCTIONS[tag]['base']}`  ")

        content.append(f"**Full name**: `ludeeus/container:{tag}`  ")
        content.append(
            f"[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name={tag})"
        )
        content.append(NEWLINE)

        content.append("## Environment variables")
        content.append(NEWLINE)
        content.append("Variable | Value \n-- | --")
        for env in sorted(envs):
            content.append(f"`{env}` | {envs[env]}")
        content.append(NEWLINE)

        if INSTRUCTIONS[tag].get("features"):
            content.append("## Features")
            content.append(NEWLINE)
            for feature in sorted(INSTRUCTIONS[tag].get("features")):
                if feature in versions["special"]:
                    content.append(f"- `{feature} ({versions['special'][feature]})`")
                else:
                    content.append(f"- `{feature}`")
            content.append(NEWLINE)

        if alpinepackages:
            content.append("## Alpine packages")
            content.append(NEWLINE)
            content.append("Package | Version \n-- | --")
            for package in sorted(alpinepackages):
                content.append(f"`{package.split('=')[0]}` | {package.split('=')[1]}")
            content.append(NEWLINE)

        if debianpackages:
            content.append("## Debian packages")
            content.append(NEWLINE)
            for package in sorted(debianpackages):
                content.append(f"- `{package}`")
            content.append(NEWLINE)

        if pythonpackages:
            content.append("## Pyhton packages")
            content.append(NEWLINE)
            content.append("Package | Version \n-- | --")
            for package in sorted(pythonpackages):
                content.append(f"`{package.split('==')[0]}` | {package.split('==')[1]}")
            content.append(NEWLINE)

        if INSTRUCTIONS[tag].get("documentation"):
            content.append("## Additional information")
            content.append(NEWLINE)
            content.append(INSTRUCTIONS[tag]["documentation"])

        content.append(NEWLINE)
        content.append(
            DOCKERFILE.format(
                generate_dockerfile(create_context(tag, load_instructions(tag)))
            )
        )

        with open(filename, "w") as fp:
            fp.write("\n".join(content))


for filename in get_instruction_files():
    filename = filename[:-5].split("/")[-1]
    INSTRUCTIONS[filename] = load_instructions(filename)
generate_documentation()
