#!/bin/bash
set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
$SCRIPT_DIR/build.sh bitbake -c cleansstate \
swift-stdlib \
libdispatch \
swift-foundation \
swift-foundation-essentials \
swift-foundation-icu \
swift-testing \
swift-xctest \
swift-hello-world \
core-image-minimal

$SCRIPT_DIR/build.sh bitbake core-image-minimal

