#!/bin/bash
set -ex
echo "Building ${PKG_NAME}."

# If building from a tarball, autogen may be unnecessary; keep tolerant:
./autogen.sh || true

# Start from conda's toolchain flags and **do not** turn warnings into errors.
# Keep your original warnings, but demote common offenders.
export CXXFLAGS="${CXXFLAGS} -O2 -g0 -Wall -Wno-unknown-pragmas -Wno-error"
# Optional: target the usual culprits seen with newer GCC/Clang
export CXXFLAGS="${CXXFLAGS} -Wno-error=deprecated-declarations -Wno-error=maybe-uninitialized"

./configure --disable-static --prefix="${PREFIX}" CXXFLAGS="${CXXFLAGS}"

# Parallel build
make -j"${CPU_COUNT}"
make install

echo "Error free exit!"

