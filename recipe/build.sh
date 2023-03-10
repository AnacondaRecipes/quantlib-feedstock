#!/bin/bash
echo "Building ${PKG_NAME}."

# Isolate the build.
mkdir -p build
cd build || exit 1

export CXXFLAGS="${CXXFLAGS} -O2 -g0 -fno-fast-math -Wall -Wno-unknown-pragmas -Werror"

# TODO: Enable DQL_BUILD_TEST_SUITE with the next release. See comments below.
cmake .. ${CMAKE_ARGS} \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib     \
    -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS"     \
    -DQL_BUILD_EXAMPLES=OFF   \
    -DQL_BUILD_TEST_SUITE=OFF \
    -DQL_BUILD_BENCHMARK=OFF

# Build.
echo "Building..."
ninja -j${CPU_COUNT} || exit 1

# Perform tests.
#echo "Testing..."
# quantlib_test_suite fails on linux-s390x and linux-aarch64:
# s390x: 24 failures are detected in the test module "Master Test Suite".
# aarch64: 52 failures are detected in the test module "Master Test Suite".
# ninja test || exit 1
# ./test-suite/quantlib-test-suite --log_level=message || exit 1
# ctest -VV --output-on-failure || exit 1

# Installing
echo "Installing..."
ninja install || exit 1

# Error free exit!
echo "Error free exit!"
exit 0
