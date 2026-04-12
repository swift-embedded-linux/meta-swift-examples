#!/bin/bash
set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rm -rf $SCRIPT_DIR/builds/sstate-cache
rm -rf $SCRIPT_DIR/builds/build-*

$SCRIPT_DIR/build.sh bitbake core-image-minimal

