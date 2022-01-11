# override scikit-build handling for macOS arm platforn on conda-forge cross-compiling
if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="arm64"
  # workaround for https://github.com/scikit-build/scikit-build/issues/589
  rm -rf $PREFIX/lib/libpython$PY_VER.dylib
  ln -sf $PREFIX/lib/libc++.dylib $PREFIX/lib/libpython$PY_VER.dylib
fi

if [ $(uname) == Darwin ]; then
    # directly setting MACOSX_DEPLOYMENT_TARGET is not supported by scikit-build
    $PYTHON -m pip install . \
            --global-option="build_ext" \
            #--global-option="--plat-name=macosx-$MACOSX_DEPLOYMENT_TARGET-$OSX_ARCH" \
            --no-build-isolation \
            --no-deps \
            --ignore-installed \
            --no-cache-dir \
            -vvv
else
    $PYTHON -m pip install . \
            --no-build-isolation \
            --no-deps \
            --ignore-installed \
            --no-cache-dir \
            -vvv
fi
