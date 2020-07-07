import sys

from scripts.build.context import create_context
from scripts.build.instructions import load_instructions
from scripts.build.dockerfile import generate_dockerfile
from scripts.build.container import create_container

DOCKERFILE = "./Dockerfile"


def build():
    instructions = load_instructions(CONTAINER)
    context = create_context(CONTAINER, instructions)
    dockerfile = generate_dockerfile(context)

    ## Create a dummy dockerfile
    with open(DOCKERFILE, "w") as df:
        df.write(dockerfile)

    return create_container(CONTAINER, context, PUBLISH)


if len(sys.argv) < 2:
    print(
        """
  usage:
    python -m scripts.builder [tag] options

  options:
    --publish       Publishes the tag to docker hub
"""
    )
    exit()
else:
    CONTAINER = sys.argv[1]
    PUBLISH = "--publish" in sys.argv
    exit(build())
