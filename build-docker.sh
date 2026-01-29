#!/bin/bash
#
# This script creates the yocto-ready docker image.
# The --build-arg options are used to pass data about the current user.
# Also, a tag is used for easy identification of the generated image.
#

# source the common variables
. ./env.sh

if [[ $PWD != $HOME* && $(whoami) != "root" ]]; then
    echo "Error: Current directory is outside $HOME"
    exit 1
fi

USERNAME=$(whoami)
if [[ $USERNAME == "root" ]]; then
  USERNAME=yocto
fi

$CONTAINER_ENGINE build --tag "${DOCKER_IMAGE_TAG}" \
             --build-arg "DOCKER_WORKDIR=${DOCKER_WORKDIR}" \
             --build-arg "USER=$USERNAME" \
             --build-arg "UID=$(id -u)" \
             --build-arg "GID=$(id -g)" \
             -f ubuntu22.04.dockerfile .
