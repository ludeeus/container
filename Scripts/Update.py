import os
import subprocess
import glob


UPDATE = "git commit -m '[{}] Update {} from {} to {}'"

def get_release_from_github(repo):
    import requests
    url = f"https://api.github.com/repos/{repo}/releases/latest"
    response = requests.get(url).json()
    return response["tag_name"]

def get_alpine_pkg_version(pkg):
    from alpinepkgs.packages import get_package
    return get_package(pkg, "v3.11")["x86_64"]["version"]

def get_debian_pkg_version(pkg):
    import requests
    url = f"https://sources.debian.org/api/src/{pkg}/"
    response = requests.get(url).json()
    if "error" in response:
        return
    for version in response["versions"]:
        if "buster" in version["suites"]:
            return version["version"]

def run_command(command):
    print(command)
    cmd = subprocess.run([x for x in command.split(" ")])
    if cmd.returncode != 0:
        exit(1)

def update_s6():
    installfile = "rootfs/s6/install"
    current = get_release_from_github("just-containers/s6-overlay")
    with open(installfile, "r") as install:
        content = install.read()
    installed = content.split("=\"")[1].split("\"\n")[0]
    if current != installed:
        content = content.replace(installed, current)
        with open(installfile, "w") as install:
            install.write(content)
        run_command("git add rootfs/s6/install")
        run_command(UPDATE.format("base-s6", "s6-overlay", installed, current))

def update_apline_pkgs():
    dockerfiles = [f for f in glob.glob("DockerFiles/" + "**/*.dockerfile", recursive=True)]
    for dockerfile in  dockerfiles:
        update_alpine_pkgs_in_dockerfile(dockerfile)

def update_alpine_pkgs_in_dockerfile(path):
    with open(path, "r") as dockerfile:
        content = dockerfile.read()
    if "RUN" not in content:
        return
    packages = [x.replace("\\", " ").strip() for x in content.split("RUN ")[1].split("\n") if "=" in x and "&&" not in x and "==" not in x]
    for pkg in packages:
        package = pkg.split("=")[0]
        installed = pkg.split("=")[1]
        if "apk add" in content:
            current = get_alpine_pkg_version(package)
        else:
            current = get_debian_pkg_version(package)
        if current is None:
            return
        if installed != current:
            container = content.split("CONTAINER_TYPE=")[1]
            container = container.split("\n")[0]
            container = container.strip()

            content = content.replace(pkg, f"{package}={current}")
            with open(path, "w") as dockerfile:
                dockerfile.write(content)
            run_command(f"git add {path}")
            run_command(UPDATE.format(container, package, installed, current))



def update_all():
    run_command("python3 -m pip install -U requests alpinepkgs")
    update_apline_pkgs()
    update_s6()


update_all()
