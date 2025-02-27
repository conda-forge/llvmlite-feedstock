#!/bin/bash

set -x

export PYTHONNOUSERSITE=1

export LLVMLITE_USE_CMAKE=1
export LLVMLITE_SHARED=0

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
elif [[ "${target_platform}" == linux-ppc64le ]]; then
    CXXFLAGS="${CXXFLAGS} -fplt"
fi

$PYTHON setup.py build --force
$PYTHON setup.py install
