#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="meta-swift-project"
DOCKER_WORKDIR="$PWD"

# Yocto

YOCTO_DIR="$PWD"

if command -v "docker ps" &> /dev/null; then
  DOCKER_CMD="docker"
elif command -v "podman ps" &> /dev/null; then
  DOCKER_CMD="podman"
  DOCKER_RUN_PARAMS="--userns=keep-id:uid=$(id -u),gid=$(id -g)"
else
  echo "Error: Neither docker nor podman is installed or available."
  exit 1
fi

echo "Found ${DOCKER_CMD}, this will be used as the container runtime."
