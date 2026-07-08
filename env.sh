#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

IMAGE_TAG=${IMAGE_TAG:="meta-swift-examples"}
WORKDIR="$PWD"

if [ -z "$CONTAINER_ENGINE" ]; then
  if docker ps &> /dev/null; then
    CONTAINER_ENGINE="docker"
  elif podman ps &> /dev/null; then
    CONTAINER_ENGINE="podman"
  else
    echo "Error: Unable to find a running 'docker' or 'podman' instance to use as the container engine."
    exit 1
  fi

  echo "Found ${CONTAINER_ENGINE}, this will be used as the container runtime."
fi

if [ "$CONTAINER_ENGINE" = "docker" ]; then
  # Add extra params for docker if needed
  CONTAINER_RUN_PARAMS=""
elif [ "$CONTAINER_ENGINE" = "podman" ]; then
  CONTAINER_RUN_PARAMS="--userns=keep-id:uid=$(id -u),gid=$(id -g)"
else
  echo "Error: Unsupported container runtime '${CONTAINER_ENGINE}'."
  exit 1
fi
