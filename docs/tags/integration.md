# integration

[Back to overview](../index.md)

_This provides a minimalistic container for working with python._

**Base image**: `alpine:3.12.0`  
**Full name**: `ludeeus/container:integration`  
[View this on Docker Hub](https://hub.docker.com/r/ludeeus/container/tags?page=1&name=integration)

## Environment variables

Variable | Value 
-- | --
`CONTAINER_TYPE` | integration
`DEVCONTAINER` | True

## Features

- `devcontainer`

## Alpine packages

Package | Version 
-- | --
`bash` | 5.0.17-r0
`ffmpeg-dev` | 4.3.1-r0
`gcc` | 9.3.0-r2
`git` | 2.26.2-r0
`libc-dev` | 0.7.2-r3
`libffi-dev` | 3.3-r2
`make` | 4.3-r0
`openssh` | 8.3_p1-r0
`openssl-dev` | 1.1.1g-r0
`py3-pip` | 20.1.1-r0
`python3-dev` | 3.8.3-r0
`python3` | 3.8.3-r0

## Pyhton packages

Package | Version 
-- | --
`black` | 19.10b0
`pylint` | 2.5.3
`setuptools` | 49.2.0
`wheel` | 0.34.2



***
<details>
<summary>Generated dockerfile</summary>

<pre>
FROM alpine:3.12.0

ENV CONTAINER_TYPE=integration
ENV DEVCONTAINER=True

COPY rootfs/common /
COPY --from=ludeeus/webhook /bin/binary /bin/webhook

RUN  \ 
    apk add --no-cache  \ 
        bash=5.0.17-r0 \ 
        ffmpeg-dev=4.3.1-r0 \ 
        gcc=9.3.0-r2 \ 
        git=2.26.2-r0 \ 
        libc-dev=0.7.2-r3 \ 
        libffi-dev=3.3-r2 \ 
        make=4.3-r0 \ 
        openssh=8.3_p1-r0 \ 
        openssl-dev=1.1.1g-r0 \ 
        py3-pip=20.1.1-r0 \ 
        python3-dev=3.8.3-r0 \ 
        python3=3.8.3-r0 \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        pip \ 
    && python3 -m pip install --no-cache-dir -U  \ 
        black==19.10b0 \ 
        pylint==2.5.3 \ 
        setuptools==49.2.0 \ 
        wheel==0.34.2 \ 
    && chmod +x /usr/bin/container \ 
    && ln -s /usr/bin/python3 /usr/bin/python \ 
    && mkdir -p /config/custom_components \ 
    && rm -rf /var/cache/apk/* \ 
    && find /usr/local \( -type d -a -name test -o -name tests -o -name '__pycache__' \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \; \ 
    && rm -fr /tmp/* /var/{cache,log}/*



<<<<<<< HEAD

=======
LABEL org.opencontainers.image.authors="Ludeeus <hi@ludeeus.dev>"
LABEL org.opencontainers.image.created="2020-07-17T16:44:39.266796"
LABEL org.opencontainers.image.description="This provides a minimalistic container for working with python."
LABEL org.opencontainers.image.documentation="https://ludeeus.github.io/container/tags/integration"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision="93a0ea023913050ae699ec6c55be7deccd9e0732"
LABEL org.opencontainers.image.source="https://github.com/ludeeus/container"
LABEL org.opencontainers.image.title="Integration"
LABEL org.opencontainers.image.url="https://ludeeus.github.io/container/tags/integration"
LABEL org.opencontainers.image.vendor="Ludeeus"
LABEL org.opencontainers.image.version="93a0ea023913050ae699ec6c55be7deccd9e0732"
>>>>>>> 589fbf4053c7812b821060e23794a83a031007b5
</pre>

<i>This is a generated version of the context used while building the container, some of the labels will not be correct since they use information in the action that publishes the container</i>
</details>
