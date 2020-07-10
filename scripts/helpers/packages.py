from alpinepkgs.packages import get_package

from scripts.helpers.files import get_versions, save_versions
from scripts.helpers.docker import get_docker_tags
from scripts.helpers.pypi import get_version_pypi

NEWPACKAGELINE = " \\ \n        "


def add_alpine_packages(context, instructions):
    if instructions.get("alpine-packages"):
        context["RUN"].append(
            f"apk add --no-cache {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['alpine-packages']))}"
        )

    return context


def cleanup_alpine_packages(context, instructions):
    if instructions.get("alpine-packages"):
        context["RUN"].append("rm -rf /var/cache/apk/*")

    return context


def add_alpine_build_packages(context, instructions):
    if instructions.get("alpine-packages-build"):
        context["RUN"].append(
            f"apk add --no-cache --virtual .build-deps {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['alpine-packages-build']))}"
        )

    return context


def cleanup_alpine_build_packages(context, instructions):
    if instructions.get("alpine-packages-build"):
        context["RUN"].append("apk del --no-cache .build-deps")

    return context


def add_debian_packages(context, instructions):
    if instructions.get("debian-packages"):
        context["RUN"].append("apt update")
        context["RUN"].append(
            f"apt install -y --no-install-recommends --allow-downgrades {NEWPACKAGELINE}{NEWPACKAGELINE.join(instructions['debian-packages'])}"
        )

    return context


def cleanup_debian_packages(context, instructions):
    if instructions.get("debian-packages"):
        context["RUN"].append("rm -fr /var/lib/apt/lists/*")

    return context


def add_python_packages(context, instructions):
    if instructions.get("python-packages"):
        context["RUN"].append(
            f"python3 -m pip install --no-cache-dir -U {NEWPACKAGELINE}pip"
        )
        context["RUN"].append(
            f"python3 -m pip install --no-cache-dir -U {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['python-packages']))}"
        )

    return context


def cleanup_python_packages(context, instructions):
    if instructions.get("python-packages"):
        context["RUN"].append(
            "find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \;"
        )

    return context


def cleanup_general(context, instructions):
    context["RUN"].append("rm -fr /tmp/* /var/{cache,log}/*")
    return context


def update_alpine_packages():
    versions = get_versions()
    alpine = f"v{versions['base']['alpine'][:-2]}"
    for package in versions["alpine"]:
        current = versions["alpine"][package]
        new = get_package(package, alpine)["versions"].pop()
        if current != new:
            versions = get_versions()
            print(f"Updating {package} from {current} to {new}")
            versions["alpine"][package] = new
            save_versions(versions)


def update_python_packages():
    versions = get_versions()
    for package in versions["python"]:
        current = versions["python"][package]
        new = get_version_pypi(package)
        if current != new:
            versions = get_versions()
            print(f"Updating {package} from {current} to {new}")
            versions["python"][package] = new
            save_versions(versions)


def update_base_images():
    versions = get_versions()
    for package in versions["base"]:
        current = versions["base"][package]
        new = get_docker_tags(package)
        if current != new:
            versions = get_versions()
            print(f"Updating {package} from {current} to {new}")
            versions["base"][package] = new
            save_versions(versions)
