#!/bin/bash

set -e

if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="arm64"
fi

$PYTHON -m pip install . \
  --no-build-isolation \
  --no-deps \
  --ignore-installed \
  --no-cache-dir \
  -vvv
