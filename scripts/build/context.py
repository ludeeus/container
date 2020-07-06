import os
from datetime import datetime
from scripts.build.files import get_rootfs_files

DOCKERFILE = "./Dockerfile"
SHA = os.getenv("GITHUB_SHA")


def create_context(tag, instructions):
    content = []
    run = []
    content.append(f"FROM {instructions['base']}")
    content.append(f"ENV CONTAINER_TYPE='{tag}'")
    if "S6" in instructions.get("features", []):
        content.append("ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2")
        content.append("ENV S6_CMD_WAIT_FOR_SERVICES=1")

    if len(instructions.get("env", [])) != 0:
        for env in instructions["env"]:
            content.append(f"ENV {env}={instructions['env'][env]}")

    if tag in get_rootfs_files():
        content.append(f"COPY rootfs/{tag} /")

    if len(instructions.get("needs", [])) == 0:
        content.append("COPY rootfs/common /")
        run.append("chmod +x /usr/bin/container")

        if instructions.get("alpine-packages") is not None:
            run.append(
                "echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories"
            )

    if instructions.get("alpine-packages") is not None:
        run.append(
            f"apk add --no-cache {' '.join(instructions['alpine-packages'])} && rm -rf /var/cache/apk/*"
        )

    if instructions.get("debian-packages") is not None:
        run.append(
            f"apt update && apt install -y --no-install-recommends --allow-downgrades {' '.join(instructions['debian-packages'])}"
            + " && rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*"
        )

    if instructions.get("python-packages") is not None:
        run.append(
            f"python3 -m pip install --no-cache-dir -U pip && python3 -m pip install --no-cache-dir -U {' '.join(instructions['python-packages'])} && "
            + " find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \;"
        )

    if len(instructions.get("run", [])) != 0:
        run.append(" && ".join(instructions["run"]))

    if instructions.get("S6"):
        content.append("COPY rootfs/s6/install /s6/install")
        run.append("bash /s6/install && rm -R /s6")

    content.append(f"RUN {' && '.join(run)}")

    if instructions.get("entrypoint") is not None:
        content.append(f"ENTRYPOINT {instructions['entrypoint']}")

    date = datetime.now()
    content.append("LABEL maintainer='hi@ludeeus.dev'")
    content.append(f"LABEL build.date='{date.year}-{date.month}-{date.day}'")
    content.append(f"LABEL build.sha='{SHA}'")

    with open(DOCKERFILE, "w") as df:
        df.write("\n".join(content))
        df.write("\n")
