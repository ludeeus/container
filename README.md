# ludeeus/container

_Custom container images used for stuff._

All container images are available under https://github.com/ludeeus?tab=packages&repo_name=container

## Custom commands included in all devcontainers

**All custom commands are prefixed with `container`**

```txt
bash-5.0# container help

  container
    Custom CLI used in this container

  usage:
    container [command]

  where [command] is one of:
    init             This will give you a fresh development environment.
    run              This will run the default action for the container you are using.
    start            This will start Home Assistant on port 9123.
    check            This will run Home Assistant config check.
    set-version      Install a specific version of Home Assistant.
    upgrade          Upgrade the installed Home Assistant version to the latest dev branch.
    help             Shows this help
```

## General devcontainer documentation

- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
- [System requirements](https://code.visualstudio.com/docs/remote/containers#_system-requirements)
