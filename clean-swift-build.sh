#!/bin/bash
set -e


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-stdlib"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate libdispatch"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-hello-world"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate core-image-minimal"

$SCRIPT_DIR/build.sh "bitbake swift-stdlib"
$SCRIPT_DIR/build.sh "bitbake libdispatch"
$SCRIPT_DIR/build.sh "bitbake swift-hello-world"
$SCRIPT_DIR/build.sh "bitbake core-image-minimal"

