#!/bin/bash
set -e

# Configuration
BUILD_ROOT=${BUILD_ROOT:=$(pwd)/builds}
SRC_ROOT="${SRC_ROOT:=$(pwd)/sources}"
OE_DIR="${OE_DIR:=$SRC_ROOT/openembedded-core}"
META_SWIFT_DIR="${META_SWIFT_DIR:=$SRC_ROOT/meta-swift}"
META_RASPBERRYPI_DIR=${META_RASPBERRYPI_DIR:=$SRC_ROOT/meta-raspberrypi}

MACHINE="${MACHINE:=qemuarm}"
BUILD_DIR=${BUILD_DIR:=$BUILD_ROOT/build-$MACHINE}
DOWNLOADS_DIR=${DOWNLOADS_DIR:=$BUILD_ROOT/downloads}
SSTATE_DIR=${SSTATE_DIR:=$BUILD_ROOT/sstate-cache}

# For SWIFT_CXX_RUNTIME, we have 2 choices:
# - "gnu" = libstdc++
# - "llvm" = libc++
SWIFT_CXX_RUNTIME=${SWIFT_CXX_RUNTIME:="gnu"}
if [ $SWIFT_CXX_RUNTIME != "gnu" ] && [ $SWIFT_CXX_RUNTIME != "llvm" ]; then
    echo "Invalid value for SWIFT_CXX_RUNTIME: $SWIFT_CXX_RUNTIME"
    echo "Valid values are: gnu, llvm"
    exit 1
fi

# Build Yocto Poky
mkdir -p $BUILD_ROOT 2> /dev/null || true
source $OE_DIR/oe-init-build-env $BUILD_DIR
bitbake-layers add-layer $SRC_ROOT/meta-yocto/meta-poky
bitbake-layers add-layer $SRC_ROOT/meta-yocto/meta-yocto-bsp
bitbake-layers add-layer $META_SWIFT_DIR
# Support for Raspberry PI devices
if [[ $MACHINE == "raspberrypi"* ]]; then
    bitbake-layers add-layer $META_RASPBERRYPI_DIR
fi
# Customize build
touch conf/sanity.conf
CONF_FILE=./conf/local.conf
rm -rf $CONF_FILE
echo "# Swift for Yocto" >> $CONF_FILE
echo "MACHINE ??= \"${MACHINE}\"" >> $CONF_FILE
echo "DL_DIR ?= \"${DOWNLOADS_DIR}\"" >> $CONF_FILE
echo "SSTATE_DIR ?= \"${SSTATE_DIR}\"" >> $CONF_FILE
echo 'EXTRA_IMAGE_FEATURES += "allow-empty-password empty-root-password allow-root-login post-install-logging"' >> $CONF_FILE
echo "IMAGE_INSTALL:append = \" swift-hello-world ${EXTRA_IMAGE_INSTALL}\"" >> $CONF_FILE
echo "SWIFT_CXX_RUNTIME = \"$SWIFT_CXX_RUNTIME\"" >> $CONF_FILE

#echo 'SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"' >> $CONF_FILE
#echo "USER_CLASSES += \"buildstats buildstats-summary\"" >> $CONF_FILE

COMMAND="$1"
COMMAND=${COMMAND:="bitbake core-image-minimal"}

# run build command
$COMMAND
