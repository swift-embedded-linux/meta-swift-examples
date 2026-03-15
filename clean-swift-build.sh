#!/bin/bash
set -ex


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-stdlib"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate libdispatch"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-foundation"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-foundation-essentials"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-foundation-icu"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-testing"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-xctest"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate swift-hello-world"
$SCRIPT_DIR/build.sh "bitbake -c cleansstate core-image-minimal"

$SCRIPT_DIR/build.sh "bitbake swift-stdlib"
$SCRIPT_DIR/build.sh "bitbake libdispatch"
$SCRIPT_DIR/build.sh "bitbake swift-foundation"
$SCRIPT_DIR/build.sh "bitbake swift-foundation-essentials"
$SCRIPT_DIR/build.sh "bitbake swift-foundation-icu"
$SCRIPT_DIR/build.sh "bitbake swift-testing"
$SCRIPT_DIR/build.sh "bitbake swift-xctest"
$SCRIPT_DIR/build.sh "bitbake swift-hello-world"
$SCRIPT_DIR/build.sh "bitbake core-image-minimal"

