#!/bin/bash
set -e

# Configuration
SRC_ROOT="${SRC_ROOT:=$(pwd)}"
POKY_DIR="${POKY_DIR:=$SRC_ROOT/poky}"
META_SWIFT_DIR="${META_SWIFT_DIR:=$SRC_ROOT/meta-swift}"
META_RASPBERRYPI_DIR=${META_RASPBERRYPI_DIR:=$SRC_ROOT/meta-raspberrypi}

MACHINE="${MACHINE:=qemuarm}"
DOWNLOADS_DIR=${DOWNLOADS_DIR:=$SRC_ROOT/downloads}
SSTATE_DIR=${SSTATE_DIR:=$SRC_ROOT/sstate-cache}

# Build Yocto Poky
cd $POKY_DIR
source oe-init-build-env build-$MACHINE
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
echo "MACHINE=\"${MACHINE}\"" >> $CONF_FILE
echo "DL_DIR ?= \"${DOWNLOADS_DIR}\"" >> $CONF_FILE
echo "SSTATE_DIR ?= \"${SSTATE_DIR}\"" >> $CONF_FILE
echo 'IMAGE_FEATURES += "debug-tweaks"' >> $CONF_FILE
echo "IMAGE_INSTALL:append = \" swift-hello-world ${EXTRA_IMAGE_INSTALL} openssh glibc-utils ldd valgrind gdb gdbserver strace\"" >> $CONF_FILE
echo 'EXTRA_IMAGE_FEATURES:append = " dbg-pkgs dev-pkgs tools-debug "' >> $CONF_FILE

#echo 'SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"' >> $CONF_FILE
#echo "USER_CLASSES += \"buildstats buildstats-summary\"" >> $CONF_FILE

# build Swift
#
#bitbake cmake-native -c cleansstate
#bitbake cmake-native
bitbake core-image-minimal
