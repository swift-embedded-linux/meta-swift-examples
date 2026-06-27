#!/bin/bash
set -e

# Configuration
BUILD_ROOT=${BUILD_ROOT:=$(pwd)/builds}
SRC_ROOT="${SRC_ROOT:=$(pwd)/sources}"
OE_DIR="${OE_DIR:=$SRC_ROOT/openembedded-core}"
MACHINE="${MACHINE:=qemuarm}"
BUILD_DIR=${BUILD_DIR:=$BUILD_ROOT/build-$MACHINE}

source "$OE_DIR/oe-init-build-env" "$BUILD_DIR"
runqemu $MACHINE snapshot nographic
