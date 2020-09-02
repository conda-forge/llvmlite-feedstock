#!/bin/bash

set -x

DARWIN_TARGET=$macos_machine
DARWIN_TARGET=x86_64-apple-darwin13.4.0

export PYTHONNOUSERSITE=1

export DISTUTILS_DEBUG=1

export LLVM_CONFIG="${PREFIX}/bin/llvm-config"
${LLVM_CONFIG} --version

sed -i.bak 's|CXX = |CXX ?= |g' ffi/Makefile.osx
diff -urN ffi/Makefile.osx.bak ffi/Makefile.osx || true
$PYTHON setup.py build --force
$PYTHON setup.py install
