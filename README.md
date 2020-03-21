# Container

_Custom container images used for stuff._

# How to use it

In your own repository create a new directory in the root called `.devcontainer`.
In that directory you need a `devcontainer.json` file, [you can use this one.](/devcontainer_example.json)

## Minimal example of `.devcontainer/devcontainer.json`

```json
{
	"image": "ludeeus/container:integration",
	"context": "..",
	"appPort": 	"8123:8123",
	"postCreateCommand": "dc install",
	"settings": {
		"terminal.integrated.shell.linux": "/bin/bash",
}
```

If you need to add a something to `configuration.yaml` for your integration create a file in your repository here `.devcontainer/configuration.yaml`, this will be copied every time you run `dc start`.

# image tags

tag | description
-- | --
base | This serves as a base for the other tags.
python | This provides a minimalistic container for working with python.
integration | This is intended to be used if you are developing a custom_component (integration) for Home Assistant.
frontend | This is intended to be used if you are developing a frontend elements.
monster | This is here to please @iantrich's crazy ideas, this combines the `integration` & `frontend` tags into one monster tag.
dotnet | This provides a minimalistic container for working with dotnet core.
netdaemon | This provides a minimalistic container for working with netdaemon apps core.
go | This provices a minimalistic container for working with go.

_You can add a `-x.x.x` postfix to each tag to specify the version._ 

# Custom commands included

**All custom commands are prefixed with `dc`**

```txt
bash-5.0# dc help

  dc
    Custom CLI used in this devcontainer

  usage:
    dc [command]

  where [command] is one of:
    init             This will give you a fresh development environment.
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


# Provided software

## Base

_Based on `apline:3.11`_

_Included in all the container/tags_

Description | version
-- | --
bash | 5.0.11-r1
git | 2.24.1-r0
nano | 4.6-r0
openssh | 8.1_p1-r0
openssl-dev | 1.1.1d-r3

## Go

_Based on `ludeeus/devcontainer:base`_

_Included in the container/tags starting with `go`_

Description | version
-- | --
go | 1.13.4-r1

## Python

_Based on `ludeeus/devcontainer:base`_

_Included in the container/tags starting with `python`_

### APK Packages

Description | version
-- | --
ffmpeg-dev | 4.2.1-r3
gcc | 9.2.0-r3
libc-dev | 0.7.2-r0
libffi-dev | 3.2.1-r6
make |4.2.1-r2
python3 | 3.8.2-r0
python3-dev | 3.8.2-r0

### Python Packages

Description | version
-- | --
black | 19.3b0
colorlog | 4.0.2
pylint | 2.3.1
python-language-server | 0.28.3

## Integration

_Based on `ludeeus/devcontainer:python`_

_Included in the container/tags starting with `integration`_

_These container/tags does not have additional software_

## Frontend

_Based on `ludeeus/devcontainer:base`_

_Included in the container/tags starting with `frontend`_

Description | version
-- | --
nodejs | 12.15.0-r1
npm | 12.15.0-r1
yarn | 1.19.2-r0

## Moster

_Based on `ludeeus/devcontainer:integration`_

_Included in the container/tags starting with `monster`_

Description | version
-- | --
nodejs | 12.15.0-r1
npm | 12.15.0-r1
yarn | 1.19.2-r0

## Dotnet

_Based on `ludeeus/devcontainer:base`_

_Included in the container/tags starting with `dotnet`_

Description | version
-- | --
dotnet | 3.1.102
icu-dev | 64.2-r0
libcurl | 7.67.0-r0
libintl | 0.20.1-r2
zlib | 1.2.11-r3

## NetDaemon

_Based on `ludeeus/devcontainer:dotnet`_

_Included in the container/tags starting with `netdaemon`_

_These container/tags does not have additional software_