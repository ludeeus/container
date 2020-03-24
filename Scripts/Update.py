import os
import subprocess


UPDATE = "echo git commit -m '[{}] Update {} from {} to {}'"

def get_release_from_github(repo):
    import requests
    url = f"https://api.github.com/repos/{repo}/releases/latest"
    response = requests.get(url).json()
    return response["tag_name"]


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

def update_all():
    run_command("python3 -m pip install requests")
    update_s6()



update_all()