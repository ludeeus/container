import json
from ruamel.yaml import YAML
from scripts.helpers.files import get_instruction_files, get_versions
from scripts.helpers.set_properties import set_envs, set_labels, set_versions

versions = get_versions()
yamlloader = YAML()


def load_instructions(container):
    _all = {}
    _bases = []
    _container = {}

    for f in [x for x in get_instruction_files() if x.startswith("./instructions/")]:
        with open(f) as file:
            tag = f.split("/")[-1].replace(".yaml", "")
            if _all.get(tag) is not None:
                print(f"Multiple files for tag ({tag}) found!")
                exit(1)
            _all[f.split("/")[-1].replace(".yaml", "")] = yamlloader.load(file)

    bases = versions["base"]
    bases["python:3.9-slim-buster"] = None

    if _all[container]["base"] not in bases:
        _bases.append(_all[container]["base"])
        while True:
            try:
                base = _all[_bases[-1]]["base"]
            except KeyError:
                break
            if base in bases:
                break
            _bases.append(base)
        _container = _all[_bases.pop()]
        _container["bases"] = _bases
        _bases.reverse()
        _bases.append(container)

        for baseimage in _bases or []:
            base = _all[baseimage]
            if base["base"] in bases:
                print(_container["base"])
                _container["base"] = base["base"]

            for element in base:
                if isinstance(base.get(element), str):
                    if element == "base":
                        continue
                    _container[element] = base[element]

                elif isinstance(base.get(element), list):
                    if _container.get(element) is None:
                        _container[element] = []
                    if base.get(element) is not None:
                        for item in base[element]:
                            if item not in _container[element]:
                                _container[element].append(item)
                            else:
                                print(f"::error:: Issue with {baseimage}")
                                exit(
                                    f"::error:: Useless definition of {item}, it's allready in the base"
                                )

                elif isinstance(base.get(element), dict):
                    if _container.get(element) is None:
                        _container[element] = {}
                    for item in base[element]:
                        _container[element][item] = base[element][item]

        if container in _container["bases"]:
            _container["bases"].remove(container)
    else:
        _container = _all[container]

    for package in _container.get("alpine-packages-build", []):
        if package in _container.get("alpine-packages", []):
            _container["alpine-packages"].remove(package)

    _container["name"] = container
    _container = set_envs(_container, container)
    _container = set_labels(_container)
    return set_versions(_container)


if __name__ == "__main__":
    import sys

    instructions = load_instructions(sys.argv[1])
    print(json.dumps(instructions, indent=2))
