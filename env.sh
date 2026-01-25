#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="meta-swift-project"
DOCKER_WORKDIR="$PWD"

if [ -z "$DOCKER_CMD" ]; then
  if command -v "docker ps" &> /dev/null; then
    DOCKER_CMD="docker"
  elif command -v podman ps &> /dev/null; then
    DOCKER_CMD="podman"
  else
    echo "Error: Could not find installed or running 'docker' or 'podman'."
    exit 1
  fi

  echo "Found ${DOCKER_CMD}, this will be used as the container runtime."
fi

if [ "$DOCKER_CMD" = "docker" ]; then
  # Add extra params for docker if needed
  DOCKER_RUN_PARAMS=""
elif [ "$DOCKER_CMD" = "podman" ]; then
  DOCKER_RUN_PARAMS="--userns=keep-id:uid=$(id -u),gid=$(id -g)"
else
  echo "Error: Unsupported container runtime '${DOCKER_CMD}'."
  exit 1
fi

# Yocto

YOCTO_DIR="$PWD"
