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

    for tag in sorted(INSTRUCTIONS):
        content.append(f"[{tag}](./tags/{tag})  ")

    with open("./docs/index.md", "w") as fp:
        fp.write('\n'.join(content))

    for tag in INSTRUCTIONS:
        filename = f"./docs/tags/{tag}.md"

        content = []
        envs = {}
        alpinepackages = []
        debianpackages = []
        pythonpackages = []
        for needs in INSTRUCTIONS[tag].get('needs', []):
            for env in INSTRUCTIONS[needs].get('env', []):
                envs[env] = INSTRUCTIONS[needs]["env"][env]
            for package in INSTRUCTIONS[needs].get('alpine-packages', []):
                alpinepackages.append(package)
            for package in INSTRUCTIONS[needs].get('debian-packages', []):
                debianpackages.append(package)
            for package in INSTRUCTIONS[needs].get('python-packages', []):
                pythonpackages.append(package)

        for env in INSTRUCTIONS[tag].get('env', []):
            envs[env] = INSTRUCTIONS[tag]["env"][env]

        for package in INSTRUCTIONS[tag].get('alpine-packages', []):
            alpinepackages.append(package)

        for package in INSTRUCTIONS[tag].get('debian-packages', []):
            debianpackages.append(package)

        for package in INSTRUCTIONS[tag].get('python-packages', []):
            pythonpackages.append(package)

        content.append(f"# {tag}")
        content.append(NEWLINE)

        content.append("[Back to overview](../index.md)")
        content.append(NEWLINE)


        if INSTRUCTIONS[tag].get('description'):
            content.append(f"_{INSTRUCTIONS[tag]['description']}_")
            content.append(NEWLINE)

        if "ludeeus" in INSTRUCTIONS[tag]["base"]:
            content.append(f"**Base image**: [{INSTRUCTIONS[tag]['base']}](./{INSTRUCTIONS[tag]['base'].split(':')[1]})  ")
        else:
            content.append(f"**Base image**: `{INSTRUCTIONS[tag]['base']}`  ")

        content.append(f"**Full name**: `ludeeus/container:{tag}`  ")
        content.append(f"[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name={tag})")
        content.append(NEWLINE)

        content.append("## Environment variables")
        content.append(NEWLINE)
        content.append("Variable | Value \n-- | --")
        content.append(f"CONTAINER_TYPE | {tag}")
        for env in sorted(envs):
            content.append(f"{env} | {envs[env]}")
        content.append(NEWLINE)

        content.append("## Features")
        content.append(NEWLINE)
        content.append("Feature | Enabled \n-- | --")
        content.append(f"S6 overlay | {INSTRUCTIONS[tag].get('S6', False) or len([x for x in INSTRUCTIONS[tag].get('needs', []) if 's6' in x]) != 0}")

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


        if INSTRUCTIONS[tag].get('documentation'):
            content.append("## Additional information")
            content.append(NEWLINE)
            content.append(INSTRUCTIONS[tag]['documentation'])




        with open(filename, "w") as fp:
            fp.write('\n'.join(content))



load_instructions()
generate_documentation()