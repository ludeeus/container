# Devcontainer

_Custom container used for development of integrations for Home Assistant._

**Base Image:** Alpine


# How to use it

In your own repository create a new directory in the root called `.devcontainer`.
In that directory you need a `devcontainer.json` file, [you can use this one.](/devcontainer_example.json)

## Minimal example of `.devcontainer/devcontainer.json`

```json
{
	"image": "ludeeus/devcontainer",
	"context": "..",
	"appPort": 	"9123:8123",
	"postCreateCommand": "dc install",
	"settings": {
		"terminal.integrated.shell.linux": "/bin/bash",
}
```

If you need to add a something to `configuration.yaml` for your integration create a file in your repository here `.devcontainer/configuration.yaml`, this will be copied everytime you run `dc start`.

# Custom commands included

**All custom commands are prefixed with `dc`**

```txt
bash-5.0# dc help

  dc
    Custom CLI used in this devcontainer

  usage:
    dc [command]

  where [command] is one of:
    start            This will start Home Assistant on port 9123.
    check            This will run Home Assistant config check.
    set-version      Install a spesific version of Home Assistant.
    upgrade          Upgrade the installed Home Assistant version to the latest dev branch.
    help             Shows this help
```

# Tasks

_If you don't want to rely on a CLI, but want to use VSCode tasks to execute them you can._

There is an [example here](.vscode/tasks.json) you can copy to `.vscode/tasks.json` in your repo.

# General devcontainer documentation

- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
- [System requirements](https://code.visualstudio.com/docs/remote/containers#_system-requirements)
