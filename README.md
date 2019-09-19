# Devcontainer

_Custom container used for development of integrations for Home Assistant._

- **Base Image:** Alpine
- Python


# How to use it

In your own repository create a new directory in the root called `.devcontainer`.
In that directory you need a `devcontainer.json` file, [you can use this one.](/devcontainer_example.json)

# Custom commands included

**All custom commands are prefixed with `dc`**

# `preview`

`dc preview` - This will start Home Assistant, and if you used the `devcontainer_example.json` file from this repository you can access it on port `9123` when it has started.

# `check`

This will run Home Assistant config check

# `version`

Install a spesific version of Aome Assistant

# `upgrade`

Upgrade the installed Home Assistant version to the latest dev branch.