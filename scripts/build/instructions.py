from ruamel.yaml import YAML
from scripts.build.files import get_instruction_files


def load_instructions(container):
    _all = {}
    _bases = []
    _container = {}

    yamlloader = YAML()

    for f in [x for x in get_instruction_files() if x.startswith("./instructions/")]:
        with open(f) as file:
            tag = f.split("/")[-1].replace(".yaml", "")
            if _all.get(tag) is not None:
                print(f"Multiple files for tag ({tag}) found!")
                exit(1)
            _all[f.split("/")[-1].replace(".yaml", "")] = yamlloader.load(file)

    if ":" in _all[container]["base"]:
        return _all[container]

    _bases.append(_all[container]["base"])
    while True:
        base = _all[_bases[-1]]["base"]
        if ":" in base:
            break
        _bases.append(base)

    _container = _all[_bases.pop()]
    _bases.reverse()
    _bases.append(container)

    for base in _bases or []:
        base = _all[base]
        if ":" not in _container["base"]:
            _container["base"] = base["base"]

        for element in ["run", "alpine-packages", "features", "env", "description"]:
            if isinstance(base.get(element), str):
                _container[element] = base[element]

            elif isinstance(base.get(element), list):
                if _container.get(element) is None:
                    _container[element] = []
                if base.get(element) is not None:
                    for item in base[element]:
                        if item not in _container[element]:
                            _container[element].append(item)

            elif isinstance(base.get(element), dict):
                if _container.get(element) is None:
                    _container[element] = {}
                for item in base[element]:
                    _container[element][item] = base[element][item]

    return _container
