import os
import sys
import subprocess

IMAGES = []

REF = os.getenv("IMAGE_TAG")
EVENT = os.getenv("GITHUB_EVENT_NAME")

def main(runtype):
    if len(runtype) == 1:
        print("Runtype is missing")
        exit(1)

    IMAGES.append(Image("base", "Dockerfiles/Base.dockerfile", []))
    IMAGES.append(Image("debian-base", "Dockerfiles/BaseDebian.dockerfile", []))

    IMAGES.append(Image("go-base", "Dockerfiles/BaseGo.dockerfile", ["base"]))
    IMAGES.append(Image("python-base", "Dockerfiles/BasePython.dockerfile", ["base"]))
    IMAGES.append(Image("dotnet-base", "Dockerfiles/BaseDotnet.dockerfile", ["debian-base"]))
    IMAGES.append(Image("nodejs-base", "Dockerfiles/BaseNodejs.dockerfile", ["base"]))

    IMAGES.append(Image("frontend", "Dockerfiles/Frontend.dockerfile", ["nodejs-base"]))
    IMAGES.append(Image("netdaemon", "Dockerfiles/Netdaemon.dockerfile", ["dotnet-base", "debian-base"]))
    IMAGES.append(Image("integration", "Dockerfiles/Integration.dockerfile", ["python-base"]))
    IMAGES.append(Image("monster", "Dockerfiles/Monster.dockerfile", ["python-base", "integration"]))

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

    def build_image(self):
        command = f"docker build --compress --no-cache -t ludeeus/devcontainer:{self.name} -f {self.dockerfile} ."
        if self.name == "base":
            command += f" -t ludeeus/devcontainer:latest"
            command += f" -t ludeeus/container:latest"
        command += f" -t ludeeus/container:{self.name}"
        run_command(command)
        self.build = True

    def publish_image(self):
        if self.name == "base":
            run_command(f'docker push ludeeus/devcontainer:latest')
            run_command(f'docker push ludeeus/container:latest')
        run_command(f'docker push ludeeus/devcontainer:{self.name}')
        run_command(f'docker push ludeeus/container:{self.name}')
        if EVENT == "release":
            run_command(f'docker push ludeeus/devcontainer:{self.name}-{REF}')
        self.published = True

def get_next(sortkey):
    if sortkey == "build":
        return sorted([x for x in IMAGES if not x.build], key=lambda x: x.needs, reverse=False)
    return sorted([x for x in IMAGES if not x.published], key=lambda x: x.needs, reverse=False)

def run_command(command):
    build = subprocess.run([x for x in command.split(" ")])
    if build.returncode != 0:
        exit(1)

def build_all():
    while True:
        image = get_next("build")
        if not image:
            break
        image = image[0]
        if [x for x in IMAGES if x.name in image.needs and not x.build]:
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
