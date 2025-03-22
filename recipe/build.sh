#!/bin/bash

set -x

export PYTHONNOUSERSITE=1

export LLVMLITE_USE_CMAKE=1
export LLVMLITE_SHARED=0

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
elif [[ "${target_platform}" == linux-ppc64le ]]; then
    # Taken from llvmdev's recipe
    # https://github.com/conda-forge/llvmdev-feedstock/blob/8c2c0f2db9db1fdf12289381dcee4e2d9a2e5fec/recipe/build.sh#L29-L33
    # disable `-fno-plt` due to some GCC bug causing linker errors, see
    # https://github.com/llvm/llvm-project/issues/51205
    CFLAGS="$(echo $CFLAGS | sed 's/-fno-plt //g')"
    CXXFLAGS="$(echo $CXXFLAGS | sed 's/-fno-plt //g')"
fi

$PYTHON setup.py build --force
$PYTHON setup.py install
