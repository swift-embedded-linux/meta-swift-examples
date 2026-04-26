#!/bin/bash
set -ex

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rm -rf $ROOT_DIR/builds/sstate-cache
rm -rf $ROOT_DIR/builds/build-*

$ROOT_DIR/build.sh bitbake core-image-minimal

