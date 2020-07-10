def add_features(context, instructions):
    if "S6" in instructions.get("features", []):
        context["COPY"].append(("rootfs/s6/install", "/s6/install"))
        context["RUN"].append("bash /s6/install")
        context["RUN"].append("rm -R /s6")

    if "devcontainer" in instructions.get("features", []):
        context["COPY"].append(("rootfs/common", "/"))
        context["COPY"].append(("--from=ludeeus/webhook /bin/binary", "/bin/webhook"))
        context["RUN"].append("chmod +x /usr/bin/container")

    return context
