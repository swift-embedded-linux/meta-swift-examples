#!/bin/bash
set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
$SCRIPT_DIR/build.sh bitbake -g swift-hello-world && find . -name "pn-buildlist" -exec cat {} + | xargs $SCRIPT_DIR/build.sh bitbake -c cleansstate 

$SCRIPT_DIR/build.sh bitbake core-image-minimal

