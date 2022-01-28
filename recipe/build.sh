#!/bin/bash

set -e

# override scikit-build handling for macOS arm platforn on conda-forge cross-compiling
if [ "$target_platform" = "osx-arm64" ]; then
  export SKBUILD_CONFIGURE_OPTIONS=${CMAKE_ARGS/CMAKE_INSTALL_PREFIX/CMAKE_INSTALL_PREFIX_BAK}
  export CMAKE_OSX_ARCHITECTURES="arm64"
  # workaround for https://github.com/scikit-build/scikit-build/issues/589
  rm -rf $PREFIX/lib/libpython$PY_VER.dylib
  ln -sf $PREFIX/lib/libc++.dylib $PREFIX/lib/libpython$PY_VER.dylib
fi

$PYTHON -m pip install . \
  --no-build-isolation \
  --no-deps \
  --ignore-installed \
  --no-cache-dir \
  -vvv
