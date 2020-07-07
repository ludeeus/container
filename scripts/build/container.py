import subprocess

DOCKERFILE = "./Dockerfile"


def create_container(container, context, publish):
    builder = ["docker", "buildx", "build"]

    builder.append("--no-cache")
    builder.append("--compress")
    builder.extend(["-t", f"ludeeus/container:{container}"])

    if publish:
        builder.append("--output=type=image,push=true")
    else:
        builder.append("--output=type=image,push=false")

    if container == "alpine-base":
        builder.extend(["-t", "ludeeus/container:latest"])

    if "-base" in container and publish:
        builder.extend(["--platform", "linux/arm,linux/arm64,linux/amd64"])
    else:
        builder.extend(["--platform", "linux/amd64"])

    builder.extend(["-f", DOCKERFILE])
    builder.append(".")

    print(builder)

    cmd = subprocess.run(builder)
    if cmd.returncode != 0:
        exit(1)
