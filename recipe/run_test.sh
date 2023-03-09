#!/bin/bash -ex

echo "Testing ${PKG_NAME}."
test -f "${PREFIX}/include/ql/quantlib.hpp"
test -f "${PREFIX}/bin/quantlib-test-suite"

${PREFIX}/bin/quantlib-test-suite --log_level=message
