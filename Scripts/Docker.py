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

    IMAGES.append(Image("alpine-base", "DockerFiles/BaseImages/OS/Alpine.dockerfile", []))
    IMAGES.append(Image("debian-base", "DockerFiles/BaseImages/OS/Debian.dockerfile", []))

    IMAGES.append(Image("go-base", "DockerFiles/BaseImages/Go.dockerfile", ["alpine-base"]))
    IMAGES.append(Image("python-base", "DockerFiles/BaseImages/Python.dockerfile", ["alpine-base"]))
    IMAGES.append(Image("dotnet-base", "DockerFiles/BaseImages/Dotnet.dockerfile", ["debian-base"]))
    IMAGES.append(Image("nodejs-base", "DockerFiles/BaseImages/Nodejs.dockerfile", ["alpine-base"]))

    #IMAGES.append(Image("frontend", "DockerFiles/Frontend.dockerfile", ["alpine-base", "nodejs-base"]))
    #IMAGES.append(Image("netdaemon", "DockerFiles/Netdaemon.dockerfile", ["dotnet-base", "debian-base"]))
    #IMAGES.append(Image("integration", "DockerFiles/Integration.dockerfile", ["alpine-base", "python-base"]))
    #IMAGES.append(Image("monster", "DockerFiles/Monster.dockerfile", ["alpine-base", "python-base", "integration"]))

    if "build" in runtype:
        build_all()
    if "publish" in runtype:
        publish_all()

class Image:
    def __init__(self, name, dockerfile, needs, multi=False):
        self.name = name
        self.dockerfile = dockerfile
        self.needs = needs
        self.build = False
        self.published = False
        self.multi = multi

    def build_image(self):
        command = f'docker buildx build --output "type=image,push=false" --platform linux/arm,linux/arm64,linux/amd64 --compress --no-cache -t ludeeus/devcontainer:{self.name} -f {self.dockerfile} .'
        if self.name == "alpine-base":
            command += f" -t ludeeus/devcontainer:latest"
            command += f" -t ludeeus/container:latest"
        command += f" -t ludeeus/container:{self.name}"
        #run_command(command)


        buildx = "docker buildx build"
        args = " --output=type=image,push=false"
        args += " --platform linux/arm,linux/arm64,linux/amd64"
        args += " --no-cache"
        args += " --compress"
        args += f" -t ludeeus/devcontainer:{self.name}"
        args += f" -t ludeeus/container:{self.name}"
        args += " -t ludeeus/devcontainer:latest"
        args += " -t ludeeus/container:latest"
        args += f" -f {self.dockerfile}"
        args += " ."
        run_command(buildx + args)

        self.build = True

    def publish_image(self):
        if self.name == "alpine-base":
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
