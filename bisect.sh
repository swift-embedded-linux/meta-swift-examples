#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# build
if ! "$SCRIPT_DIR/run-container.sh" "$SCRIPT_DIR/clean-full-build.sh"; then
    echo "Build failed → bisect skip"
    exit 125
fi

# run test
if "$SCRIPT_DIR/run-container.sh" "$SCRIPT_DIR/execute.exp"; then
    echo "Test passed → bisect good"
    exit 0
else
    echo "Test failed → bisect bad"
    exit 1
fi
