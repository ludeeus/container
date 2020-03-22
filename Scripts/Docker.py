import os
import sys
import subprocess

IMAGES = []

REF = os.getenv("IMAGE_TAG")
EVENT = os.getenv("GITHUB_EVENT_NAME")
WORKSPACE = os.getenv("GITHUB_WORKSPACE")

def main(runtype):
    if len(runtype) == 1:
        print("Runtype is missing")
        exit(1)

    IMAGES.append(Image("alpine-base", "BaseImages/OS/Alpine.dockerfile", []))
    #IMAGES.append(Image("debian-base", "BaseImages/OS/Debian.dockerfile", []))

    #IMAGES.append(Image("go-base", "BaseImages/Go.dockerfile", ["alpine-base"]))
    #IMAGES.append(Image("python-base", "BaseImages/Python.dockerfile", ["alpine-base"]))
    #IMAGES.append(Image("dotnet-base", "", []))
    #IMAGES.append(Image("nodejs-base", "BaseImages/Nodejs.dockerfile", ["alpine-base"]))

    #IMAGES.append(Image("frontend", "Frontend.dockerfile", ["alpine-base", "nodejs-base"]))
    #IMAGES.append(Image("netdaemon", "Netdaemon.dockerfile", ["dotnet-base", "debian-base"]))
    #IMAGES.append(Image("integration", "Integration.dockerfile", ["alpine-base", "python-base"]))
    #IMAGES.append(Image("monster", "Monster.dockerfile", ["alpine-base", "python-base", "integration"]))

    if "build" in runtype:
        build_all()
    if "publish" in runtype:
        publish_all()

class Image:
    def __init__(self, name, dockerfile, needs, multi=True):
        self.name = name
        self.dockerfile = dockerfile
        self.needs = needs
        self.build = False
        self.published = False
        self.multi = multi

    def constructCmd(self, publish=False):
        for arch in ["arm", "arm64", "amd64"]:
            buildx = "docker buildx build"
            args = " --load"
            args += f" --platform linux/{arch}"
            args += " --no-cache"
            args += " --compress"
            args += f" -t ludeeus/container:{self.name}-{arch}"
            if self.name == "dotnet-base":
                args += f" -f {WORKSPACE}/DockerFiles/DotNet/{arch}.dockerfile"
            else:
                args += f" -f {WORKSPACE}/DockerFiles/{self.dockerfile}"
            args += " ."
            run_command(buildx + args)

            run_command("docker images")

        if publish:
            command = f"docker manifest create ludeeus/container:{self.name}"
            command += f" ludeeus/container:{self.name}-arm"
            command += f" ludeeus/container:{self.name}-arm64"
            command += f" ludeeus/container:{self.name}-amd64"
            run_command(command)
            run_command(f"docker manifest inspect ludeeus/container:{self.name}")
            run_command(f"docker manifest annotate ludeeus/container:{self.name} ludeeus/container:{self.name}-arm --arch arm --os linux")
            run_command(f"docker manifest annotate ludeeus/container:{self.name} ludeeus/container:{self.name}-arm64 --arch arm64 --os linux")
            run_command(f"docker manifest annotate ludeeus/container:{self.name} ludeeus/container:{self.name}-amd64 --arch amd64 --os linux")
            run_command(f"docker manifest inspect ludeeus/container:{self.name}")
            run_command(f"docker manifest push --purge ludeeus/container:{self.name}")

    def build_image(self):
        self.constructCmd()
        self.build = True

    def publish_image(self):
        self.constructCmd(True)
        self.published = True

def get_next(sortkey):
    if "image" in sys.argv:
        image = sys.argv[-1]
        images = [x for x in IMAGES if x.name == image]
    else:
        images = IMAGES
    if sortkey == "build":
        return sorted([x for x in images if not x.build], key=lambda x: x.needs, reverse=False)
    return sorted([x for x in images if not x.published], key=lambda x: x.needs, reverse=False)

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
