#!/bin/bash
set -ex

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
$ROOT_DIR/build.sh bitbake -c cleansstate \
virtual/swift-native \
swift-stdlib \
libdispatch \
swift-foundation \
swift-foundation-essentials \
swift-foundation-icu \
swift-testing \
swift-xctest \
swift-hello-world \
core-image-minimal

$ROOT_DIR/build.sh bitbake core-image-minimal

