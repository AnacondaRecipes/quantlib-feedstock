#!/bin/bash
echo "Building ${PKG_NAME}."

./autogen.sh
./configure --disable-static CXXFLAGS="-O2 -g0 -Wall -Wno-unknown-pragmas -Werror" --prefix $PREFIX
make
make install

# Error free exit!
echo "Error free exit!"
exit 0
