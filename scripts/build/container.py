import subprocess

DOCKERFILE = "./Dockerfile"


def create_container(container, context, publish):
    builder = ["docker buildx build"]

    builder.append("--no-cache")
    builder.append("--compress")
    builder.append(f"-t ludeeus/container:{container}")

    if publish:
        builder.append("--output=type=image,push=true")
    else:
        builder.append("--output=type=image,push=false")

    if "-base" in container and publish:
        builder.append("--platform linux/arm,linux/arm64,linux/amd64")
    else:
        builder.append("--platform linux/amd64")

    if container == "alpine-base":
        builder.append(f"-t ludeeus/container:latest")

    builder.append(f"-f {DOCKERFILE}")
    builder.append(".")

    run_command(builder)


def run_command(commands):
    print(" ".join(commands))
    cmd = subprocess.run(commands)
    if cmd.returncode != 0:
        exit(1)
