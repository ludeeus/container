import os
import glob


def get_instruction_files():
    return [f for f in glob.glob("./" + "**/*.yaml", recursive=True)]


def get_rootfs_files():
    files = []
    for _, directory, _ in os.walk("rootfs"):
        if "common" in directory and "s6" in directory:
            files.extend(directory)
    return files
