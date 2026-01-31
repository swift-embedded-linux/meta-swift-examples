#!/bin/bash
#
. ./env.sh

if [[ $PWD != $HOME* && $(whoami) != "root" ]]; then
    echo "Error: Current directory is outside $HOME"
    exit 1
fi

# run the docker image
docker run -i --rm \
  --volume ${HOME}:${HOME} \
  --device /dev/net/tun \
  --cap-add=NET_ADMIN \
    "${IMAGE_TAG}" \
    "$@"
