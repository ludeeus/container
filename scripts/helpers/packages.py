from alpinepkgs.packages import get_package

from scripts.helpers.files import get_versions, save_versions
from scripts.helpers.docker import get_docker_tags
from scripts.helpers.pypi import get_version_pypi


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
