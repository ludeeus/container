from scripts.helpers.files import get_rootfs_files
from scripts.helpers.packages import (
    add_alpine_build_packages,
    add_alpine_packages,
    add_debian_packages,
    add_python_packages,
    cleanup_alpine_build_packages,
    cleanup_alpine_packages,
    cleanup_debian_packages,
    cleanup_python_packages,
    cleanup_general,
)
from scripts.helpers.add_features import add_features

ROOTFS = get_rootfs_files()


def create_context(tag, instructions):
    context = {
        "FROM": None,
        "ENV": [],
        "COPY": [],
        "RUN": [],
        "LABEL": [],
        "ENTRYPOINT": None,
    }
    context["FROM"] = instructions["base"]

    for env in instructions.get("env", []):
        context["ENV"].append((env, instructions["env"][env]))

    for env in instructions.get("label", []):
        context["LABEL"].append((env, instructions["label"][env]))

    for base in instructions.get("bases", []) + [tag]:
        if base in ROOTFS:
            context["COPY"].append((f"rootfs/{base}", "/"))

    if instructions.get("entrypoint"):
        context["ENTRYPOINT"] = instructions["entrypoint"]

    context = add_alpine_packages(context, instructions)
    context = add_alpine_build_packages(context, instructions)
    context = add_debian_packages(context, instructions)
    context = add_python_packages(context, instructions)

    context = add_features(context, instructions)

    for run in instructions.get("run", []):
        context["RUN"].append(run)

    context = cleanup_alpine_packages(context, instructions)
    context = cleanup_alpine_build_packages(context, instructions)
    context = cleanup_debian_packages(context, instructions)
    context = cleanup_python_packages(context, instructions)
    context = cleanup_general(context, instructions)

    return context


if __name__ == "__main__":
    import sys
    from scripts.build.instructions import load_instructions
    from scripts.build.dockerfile import generate_dockerfile
    from scripts.build.container import DOCKERFILE

    instructions = load_instructions(sys.argv[1])
    dockerfile = generate_dockerfile(create_context(sys.argv[1], instructions))
    with open(DOCKERFILE, "w") as df:
        df.write(dockerfile)
    print(instructions)
    print(dockerfile)
