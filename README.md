# ludeeus/container

_Custom container images used for stuff._

[The documentation for the container images can be found here](https://ludeeus.github.io/container/)

## Container definitions

The container definitions are located under [./instructions/](https://github.com/ludeeus/container/tree/master/instructions)
There are 3 categories of containers here:

Category | Description
-- | --
Baseimages | These are container bases that are used as a base for other containers, all base images have a `s6` variant, all base images have a `-base` postfix in the name, and all base images are multiarch.
Containers | These are containers that are ready to be used.
Development | These are containers that are perfect for development, preferably by using it as a [devcontainer](https://code.visualstudio.com/docs/remote/containers).

[Examples for devcontainer definitions can be found here](https://github.com/ludeeus/container/tree/master/devcontainer_samplefiles)


## Container instructions

The container instructions are defined using `YAML`, this is a list of the supported YAML tags that can be used:
The tag of the container will be the same as the filename of the instruction file (without the `.yaml` postfix).

YAML tag | Optional | Type | Desctiption
-- | -- | -- |--
`base` | False | string | This is the base image
`description` | True | string | A short description of the container (used for documentation).
`needs` | True | list of strings | A list of other tags this container relies on.
`env` | True | map | A key-value map of environment variables.
`S6` | True | boolean | A boolean to set if S6 overlay is added to the container (defaults to false).
`alpine-packages` | True | list of strings | A list of alpine packages to add to the container.
`debian-packages` | True | list of strings | A list of debian packages to add to the container.
`pyhton-packages` | True | list of strings | A list of python packages to add to the container.
`run` | True | list of string  | Additional "RUN" stepes to add to the container.
`entrypoint` | True | list of strings | This will be used as the "ENTRYPOINT" in the images.
`documentation` | True | string | Additional documentation for the container.

If files/more complicated scripts are needed to build the container, these can be added to a tag spesific directory under [./rootfs/](https://github.com/ludeeus/container/tree/master/rootfs).

## Custom commands included in all containers

**All custom commands are prefixed with `cc`**

```txt
bash-5.0# cc help

  cc
    Custom CLI used in this container
    cc is short for custom container

  usage:
    cc [command]

  where [command] is one of:
    init             This will give you a fresh development environment.
    run              This will run the default action for the container you are using.
    start            This will start Home Assistant on port 9123.
    check            This will run Home Assistant config check.
    set-version      Install a spesific version of Home Assistant.
    upgrade          Upgrade the installed Home Assistant version to the latest dev branch.
    help             Shows this help
```

## General devcontainer documentation

- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
- [System requirements](https://code.visualstudio.com/docs/remote/containers#_system-requirements)
