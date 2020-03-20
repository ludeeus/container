import os
import sys
import subprocess

REPO = "ludeeus/devcontainer"
IMAGES = []

def main(runtype):
    if len(runtype) == 1:
        print("Runtype is missing")
        exit(1)

    print("Adding images")
    IMAGES.append(Image("base", "Base.dockerfile", []))
    IMAGES.append(Image("base-debian", "BaseDebian.dockerfile", []))

    IMAGES.append(Image("python", "Dockerfiles/Python.dockerfile", ["base"]))
    IMAGES.append(Image("dotnet", "Dockerfiles/Dotnet.dockerfile", ["base-debian"]))
    IMAGES.append(Image("netdaemon", "Dockerfiles/Netdaemon.dockerfile", ["dotnet", "base-debian"]))
    IMAGES.append(Image("integration", "Dockerfiles/Integration.dockerfile", ["python"]))
    IMAGES.append(Image("frontend", "Dockerfiles/Frontend.dockerfile", ["base"]))
    IMAGES.append(Image("monster", "Dockerfiles/Monster.dockerfile", ["python", "integration"]))

    if "build" in runtype:
        print("")
        build_all()
    if "publish" in runtype:
        print("")
        publish_all()

class Image:
    def __init__(self, name, dockerfile, needs):
        self.name = name
        self.dockerfile = dockerfile
        self.needs = needs
        self.build = False
        self.published = False

    def build_image(self):
        tags = f"-t {REPO}:{self.name}"
        if self.name == "base":
            tags += f" -t {REPO}:latest"

        build = subprocess.run([
                "docker",
                "build",
                "--compress",
                "--no-cache",
                tags,
                f"-f {self.dockerfile}",
                "."
            ])
        print(build.stdout)
        if build.returncode != 0:
            exit(1)
        self.build = True

    def publish_image(self):
        if self.name == "base":
            print(f'docker push {REPO}:latest')
        print(f'docker push {REPO}:{self.name}')
        self.published = True

def get_next(sortkey):
    if sortkey == "build":
        return sorted([x for x in IMAGES if not x.build], key=lambda x: x.needs, reverse=False)
    return sorted([x for x in IMAGES if not x.published], key=lambda x: x.needs, reverse=False)


def build_all():
    print("Starting build")
    while True:
        image = get_next("build")
        if not image:
            print("Build is done")
            break
        image = image[0]
        if [x for x in IMAGES if x.name in image.needs and not x.build]:
            print("Build strategy is not correct")
            exit(1)
        image.build_image()


def publish_all():
    print("Starting publish")
    while True:
        image = get_next("published")
        if not image:
            print("Publish is done")
            break
        image = image[0]
        image.publish_image()

main(sys.argv)