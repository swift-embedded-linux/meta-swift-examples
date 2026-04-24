#!/bin/bash
set -ex

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
$ROOT_DIR/build.sh bitbake -g swift-hello-world && find . -name "pn-buildlist" -exec cat {} + | xargs $ROOT_DIR/build.sh bitbake -c cleansstate 

$ROOT_DIR/build.sh bitbake core-image-minimal

