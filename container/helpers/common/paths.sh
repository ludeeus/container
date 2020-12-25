#!/usr/bin/env bash

function workspacePath {
  echo "$(find /workspaces -mindepth 1 -maxdepth 1 -type d)/"
}