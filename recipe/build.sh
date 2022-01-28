#!/bin/bash

set -e

# override scikit-build handling for macOS arm platforn on conda-forge cross-compiling
if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="arm64"
fi

$PYTHON -m pip install . \
  --no-build-isolation \
  --no-deps \
  --ignore-installed \
  --no-cache-dir \
  -vvv
