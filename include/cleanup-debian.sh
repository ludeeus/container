#!/usr/bin/env bash

apt-get clean -y
rm -fr /var/lib/apt/lists/*
rm -fr /tmp/* /var/{cache,log}/*