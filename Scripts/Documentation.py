import glob
from ruamel.yaml import YAML

INSTRUCTIONS = {}
NEWLINE = ""

def load_instructions():
    yaml = YAML()
    files = [f for f in glob.glob("./" + "**/*.yaml", recursive=True)]
    for f in [x for x in files if x.startswith("./instructions/")]:
        with open(f) as file:
            tag = f.split("/")[-1].replace(".yaml", "")
            if INSTRUCTIONS.get(tag) is not None:
                print(f"Multiple files for tag ({tag}) found!")
                exit(1)
            INSTRUCTIONS[f.split("/")[-1].replace(".yaml", "")] = yaml.load(file)

def generate_documentation():

    content = []
    content.append("# ludeeus/container")
    content.append(NEWLINE)
    content.append("Click on the tag name below to see the documentation for a specific tag:")
    content.append(NEWLINE)

    for tag in INSTRUCTIONS:
        content.append(f"[{tag}](./tags/{tag})  ")

    with open("./docs/index.md", "w") as fp:
        fp.write('\n'.join(content))

    for tag in INSTRUCTIONS:
        filename = f"./docs/tags/{tag}.md"
        content = []
        content.append(f"# {tag}")
        content.append(NEWLINE)

        content.append("[Back to overview](../index.md)")
        content.append(NEWLINE)

        if INSTRUCTIONS[tag].get('description'):
            content.append(f"_{INSTRUCTIONS[tag]['description']}_")
            content.append(NEWLINE)

        if "ludeeus" in INSTRUCTIONS[tag]["base"]:
            content.append(f"**Base image**: [{INSTRUCTIONS[tag]['base']}](./{INSTRUCTIONS[tag]['base'].split(':')[1]})")
        else:
            content.append(f"**Base image**: `{INSTRUCTIONS[tag]['base']}`")

        content.append(NEWLINE)
        content.append(f"**Full name**: `ludeeus/container:{tag}`")
        content.append(NEWLINE)

        content.append("## Environment variables")
        content.append(NEWLINE)
        content.append("Variable | Value \n-- | --")
        content.append(f"CONTAINER_TYPE | {tag}")
        for env in INSTRUCTIONS[tag].get('env', []):
            content.append(f"{env} | {INSTRUCTIONS[tag]['env'][env]}")
        content.append(NEWLINE)

        content.append("## Features")
        content.append(NEWLINE)
        content.append("Feature | Enabled \n-- | --")
        content.append(f"S6 overlay | {INSTRUCTIONS[tag].get('S6', False)}")

        content.append(NEWLINE)

        if INSTRUCTIONS[tag].get('alpine-packages', []):
            content.append("## Alpine packages")
            content.append(NEWLINE)
            content.append("Package | Version \n-- | --")
            for package in INSTRUCTIONS[tag]["alpine-packages"]:
                content.append(f"`{package.split('=')[0]}` | {package.split('=')[1]}")
            content.append(NEWLINE)

        if INSTRUCTIONS[tag].get('debian-packages', []):
            content.append("## Debian packages")
            content.append(NEWLINE)
            content.append("Package | Version \n-- | --")
            for package in INSTRUCTIONS[tag]["debian-packages"]:
                content.append(f"`{package.split('=')[0]}` | {package.split('=')[1]}")
            content.append(NEWLINE)

        if INSTRUCTIONS[tag].get('python-packages', []):
            content.append("## Pyhton packages")
            content.append(NEWLINE)
            content.append("Package | Version \n-- | --")
            for package in INSTRUCTIONS[tag]["python-packages"]:
                content.append(f"`{package.split('==')[0]}` | {package.split('==')[1]}")
            content.append(NEWLINE)


        if INSTRUCTIONS[tag].get('documentation'):
            content.append("## Additional information")
            content.append(NEWLINE)
            content.append(INSTRUCTIONS[tag]['documentation'])




        with open(filename, "w") as fp:
            fp.write('\n'.join(content))



load_instructions()
generate_documentation()