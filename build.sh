#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BUILD_ROOT="${BUILD_ROOT:=$ROOT_DIR/builds}"
SRC_ROOT="${SRC_ROOT:=$ROOT_DIR/sources}"

MACHINE="${MACHINE:=qemuarm}"

BUILD_DIR="${BUILD_DIR:=$BUILD_ROOT/build-$MACHINE}"

DOWNLOADS_DIR="${DOWNLOADS_DIR:=$BUILD_ROOT/downloads}"
SSTATE_DIR="${SSTATE_DIR:=$BUILD_ROOT/sstate-cache}"

BITBAKE_DIR="${BITBAKE_DIR:=$SRC_ROOT/bitbake}"

META_SWIFT_DIR="${META_SWIFT_DIR:=$SRC_ROOT/meta-swift}"
META_RASPBERRYPI_DIR="${META_RASPBERRYPI_DIR:=$SRC_ROOT/meta-raspberrypi}"

mkdir -p "$BUILD_ROOT"

# Initialize build environment if missing
if [[ ! -f "$BUILD_DIR/bitbake-builds/poky-wrynose/build/init-build-env" ]]; then
    mkdir -p "$BUILD_DIR"

    pushd "$BUILD_DIR" >/dev/null
    "$BITBAKE_DIR/bin/bitbake-setup" init
    popd >/dev/null
fi

"$BITBAKE_DIR/bin/bitbake-setup" install-buildtools --setup-dir "$BUILD_DIR/bitbake-builds/poky-wrynose"
# Load environment
#builds/build-qemuarm/bitbake-builds/poky-wrynose/build/
#
# Activate buildtools environment
set +u
source "$BUILD_DIR/bitbake-builds/poky-wrynose/buildtools/environment-setup-x86_64-pokysdk-linux"
set -u

set +u
source "$BUILD_DIR/bitbake-builds/poky-wrynose/build/init-build-env"
set -u

# Add layers
bitbake-layers add-layer "$META_SWIFT_DIR"

if [[ $MACHINE == raspberrypi* ]]; then
    bitbake-layers add-layer "$META_RASPBERRYPI_DIR"
fi

# Configure build
CONF_FILE=./conf/local.conf
rm -rf $CONF_FILE

echo "MACHINE ??= \"${MACHINE}\"" >> $CONF_FILE

echo "" >> $CONF_FILE
echo "DL_DIR ?= \"${DOWNLOADS_DIR}\"" >> $CONF_FILE
echo "SSTATE_DIR ?= \"${SSTATE_DIR}\"" >> $CONF_FILE

echo "" >> $CONF_FILE
echo "IMAGE_FEATURES += \"allow-empty-password allow-root-login\"" >> $CONF_FILE

echo "" >> $CONF_FILE
echo "IMAGE_INSTALL:append = \" swift-hello-world ${EXTRA_IMAGE_INSTALL:-}\"" >> $CONF_FILE

COMMAND="${*:-bitbake core-image-minimal}"

echo "=============== BUILD COMMAND: $COMMAND"

eval "$COMMAND"
