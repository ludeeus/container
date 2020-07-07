import os
import glob
from ruamel.yaml import YAML

yamlloader = YAML()


def get_instruction_files():
    return [
        f for f in glob.glob("./" + "**/*.yaml", recursive=True) if "versions" not in f
    ]


def get_rootfs_files():
    files = []
    for _, directory, _ in os.walk("rootfs"):
        if "common" in directory and "s6" in directory:
            files.extend(directory)
    return files


def get_versions():
    return {
        "base": yamlloader.load(open("instructions/versions/base.yaml", "r")),
        "alpine": yamlloader.load(open("instructions/versions/alpine.yaml", "r")),
        "python": yamlloader.load(open("instructions/versions/python.yaml", "r")),
        "special": yamlloader.load(open("instructions/versions/special.yaml", "r")),
    }


def save_versions(versions):
    for version in versions:
        with open(f"instructions/versions/{version}.yaml", "w") as target:
            yamlloader.dump(versions[version], target)
