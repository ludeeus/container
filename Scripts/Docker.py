import os
import sys
import subprocess
from datetime import datetime

IMAGES = []

REF = os.getenv("IMAGE_TAG")
EVENT = os.getenv("GITHUB_EVENT_NAME")
WORKSPACE = os.getenv("GITHUB_WORKSPACE")
SHA = os.getenv("GITHUB_SHA")
CHANGED_FILES = os.getenv("CHANGED_FILES")


def append_docker_lables(dockerfile):
    with open(dockerfile, "a") as df:
        date = datetime.now()
        df.write("\n\nLABEL maintainer='hi@ludeeus.dev'\n")
        df.write(f"LABEL build.date='{date.year}-{date.month}-{date.day}'\n")
        df.write(f"LABEL build.sha='{SHA}'")


def main(runtype):
    if len(runtype) == 1:
        print("Runtype is missing")
        exit(1)

    # fmt: off
    # OS Base
    IMAGES.append(Image("alpine-base", "BaseImages/OS/Alpine.dockerfile", []))
    IMAGES.append(Image("debian-base", "BaseImages/OS/Debian.dockerfile", []))

    # OS Base With S6 overlay
    IMAGES.append(Image("alpine-base-s6", "BaseImages/OS/AlpineS6.dockerfile", ["alpine-base"]))
    IMAGES.append(Image("debian-base-s6", "BaseImages/OS/DebianS6.dockerfile", ["debian-base"]))

    # Sorfware Base
    IMAGES.append(Image("python-base", "BaseImages/Python.dockerfile", ["alpine-base"]))
    IMAGES.append(Image("dotnet-base", "BaseImages/Dotnet.dockerfile", ["debian-base"]))
    IMAGES.append(Image("nodejs-base", "BaseImages/Nodejs.dockerfile", ["alpine-base"]))

    # Sorfware Base with S6 overlay
    IMAGES.append(Image("python-base-s6", "BaseImages/PythonS6.dockerfile", ["alpine-base","alpine-base-s6"]))
    IMAGES.append(Image("dotnet-base-s6", "BaseImages/DotnetS6.dockerfile", ["debian-base","debian-base-s6"]))
    IMAGES.append(Image("nodejs-base-s6", "BaseImages/NodejsS6.dockerfile", ["alpine-base","alpine-base-s6"]))

    # Reqular (amd64 only)
    IMAGES.append(Image("go", "Go.dockerfile", ["alpine-base"]))
    IMAGES.append(Image("elastic-ek", "ElasticEK.dockerfile", ["alpine-base", "alpine-base-s6"]))
    IMAGES.append(Image("frontend", "Frontend.dockerfile", ["alpine-base", "nodejs-base"]))
    IMAGES.append(Image("netdaemon", "Netdaemon.dockerfile", ["dotnet-base", "debian-base"]))
    IMAGES.append(Image("integration", "Integration.dockerfile", ["alpine-base", "python-base"]))
    IMAGES.append(Image("python", "Python.dockerfile", ["alpine-base", "python-base"]))
    IMAGES.append(Image("monster", "Monster.dockerfile", ["alpine-base", "python-base", "integration"]))
    # fmt: on

    if "build" in runtype:
        build_all()
    if "publish" in runtype:
        publish_all()


class Image:
    def __init__(self, name, dockerfile, needs):
        self.name = name
        self.dockerfile = dockerfile
        self.needs = needs
        self.build = False
        self.published = False

    def constructCmd(self, publish=False):
        if not self.is_build_needed():
            print(f"Skipping build for {self.name}, the changed files is not used here.")
            return
        buildx = "docker buildx build"
        if publish:
            append_docker_lables(f"./DockerFiles/{self.dockerfile}")
            args = " --output=type=image,push=true"
        elif "build" in sys.argv:
            args = " --load"
        else:
            args = " --output=type=image,push=false"
        if "-base" in self.name and "build" not in sys.argv:
            args += " --platform linux/arm,linux/arm64,linux/amd64"
        else:
            args += " --platform linux/amd64"
        args += " --no-cache"
        args += " --compress"
        args += f" -t ludeeus/container:{self.name}"
        if self.name == "alpine-base":
            args += f" -t ludeeus/container:latest"
        args += f" -f {WORKSPACE}/DockerFiles/{self.dockerfile}"
        args += " ."
        run_command(buildx + args)

    def build_image(self):
        self.constructCmd()
        self.build = True

    def publish_image(self):
        self.constructCmd(True)
        self.published = True

    def is_build_needed(self):
        if self.dockerfile in CHANGED_FILES:
            return True
        if self.name in CHANGED_FILES:
            return True
        if self.needs:
            for name in self.needs:
                if get_dockerfile_from_name(name) in CHANGED_FILES:
                    return True
        if "rootfs/common" in CHANGED_FILES:
            return True
        if "rootfs/s6" in CHANGED_FILES and "s6" in self.name:
            return True
        return False

def get_next(sortkey):
    if "image" in sys.argv:
        image = sys.argv[-1]
        images = [x for x in IMAGES if x.name == image]
    else:
        images = IMAGES
    if sortkey == "build":
        return sorted(
            [x for x in images if not x.build], key=lambda x: x.needs, reverse=False
        )
    return sorted(
        [x for x in images if not x.published], key=lambda x: x.needs, reverse=False
    )

def get_dockerfile_from_name(name):
    return [x.dockerfile for x in IMAGES if x.name == name][0]

def run_command(command):
    print(command)
    cmd = subprocess.run([x for x in command.split(" ")])
    if cmd.returncode != 0:
        exit(1)


def build_all():
    while True:
        image = get_next("build")
        if not image:
            break
        image = image[0]
        if [x for x in IMAGES if x.name in image.needs and not x.build] and "image" not in sys.argv:
            print("Build strategy is not correct")
            exit(1)
        image.build_image()


def publish_all():
    while True:
        image = get_next("published")
        if not image:
            break
        image = image[0]
        image.publish_image()


print(os.environ)
main(sys.argv)
