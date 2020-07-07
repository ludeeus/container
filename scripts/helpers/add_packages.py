NEWPACKAGELINE = " \\ \n        "


def add_alpine_packages(context, instructions):
    if instructions.get("alpine-packages"):
        context["RUN"].append(
            "echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories"
        )
        context["RUN"].append(
            f"apk add --no-cache {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['alpine-packages']))}"
        )

    return context


def cleanup_alpine_packages(context, instructions):
    if instructions.get("alpine-packages"):
        context["RUN"].append("rm -rf /var/cache/apk/*")

    return context


def add_alpine_build_packages(context, instructions):
    if instructions.get("alpine-packages-build"):
        context["RUN"].append(
            f"apk add --no-cache --virtual .build-deps {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['alpine-packages-build']))}"
        )

    return context


def cleanup_alpine_build_packages(context, instructions):
    if instructions.get("alpine-packages-build"):
        context["RUN"].append("apk del .build-deps")

    return context


def add_debian_packages(context, instructions):
    if instructions.get("debian-packages"):
        context["RUN"].append("apt update")
        context["RUN"].append(
            f"apt install -y --no-install-recommends --allow-downgrades {NEWPACKAGELINE}{NEWPACKAGELINE.join(instructions['debian-packages'])}"
        )

    return context


def cleanup_debian_packages(context, instructions):
    if instructions.get("debian-packages"):
        context["RUN"].append("rm -fr /tmp/* /var/{cache,log}/* /var/lib/apt/lists/*")

    return context


def add_python_packages(context, instructions):
    if instructions.get("python-packages"):
        context["RUN"].append(
            f"python3 -m pip install --no-cache-dir -U {NEWPACKAGELINE}pip"
        )
        context["RUN"].append(
            f"python3 -m pip install --no-cache-dir -U {NEWPACKAGELINE}{NEWPACKAGELINE.join(sorted(instructions['python-packages']))}"
        )

    return context


def cleanup_python_packages(context, instructions):
    if instructions.get("python-packages"):
        context["RUN"].append(
            "find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \;"
        )

    return context
