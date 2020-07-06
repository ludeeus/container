import os
import sys
import subprocess
from datetime import datetime

import glob
from ruamel.yaml import YAML

REF = os.getenv("IMAGE_TAG")
EVENT = os.getenv("GITHUB_EVENT_NAME")
WORKSPACE = os.getenv("GITHUB_WORKSPACE")
SHA = os.getenv("GITHUB_SHA")
CHANGED_FILES = os.getenv("CHANGED_FILES").split(" ")

INSTRUCTIONS = {}
ROOTFS = []


def load_instructions():
    for _, directory, _ in os.walk("rootfs"):
        if "common" in directory and "s6" in directory:
            ROOTFS.extend(directory)
    yaml = YAML()
    files = [f for f in glob.glob("./" + "**/*.yaml", recursive=True)]
    for f in [x for x in files if x.startswith("./instructions/")]:
        with open(f) as file:
            tag = f.split("/")[-1].replace(".yaml", "")
            if INSTRUCTIONS.get(tag) is not None:
                print(f"Multiple files for tag ({tag}) found!")
                exit(1)
            INSTRUCTIONS[f.split("/")[-1].replace(".yaml", "")] = yaml.load(file)
