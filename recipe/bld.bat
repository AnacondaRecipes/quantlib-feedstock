:: cmd
echo "Building %PKG_NAME%."

:: Isolate the build.
mkdir build
cd build
if errorlevel 1 exit /b 1

:: Generate the build files.
echo "Generating the build files..."
:: According to upstream https://github.com/lballabio/QuantLib/issues/15522
:: build_shared_libs is not supported on Windows, so build a static
:: QuantLib library but use the dynamic runtime so the library can be used
:: with python.
cmake -G Ninja ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL  ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
    -D BUILD_SHARED_LIBS=OFF  ^
    -D Boost_USE_STATIC_LIBS=OFF  ^
    -D Boost_USE_STATIC_RUNTIME=OFF  ^
    -D QL_BUILD_EXAMPLES=OFF  ^
    -D QL_BUILD_TEST_SUITE=ON  ^
    -D QL_BUILD_BENCHMARK=OFF  ^
    %SRC_DIR%
if errorlevel 1 exit /b 1

:: Build.
echo "Building..."
:: ninja as the build tool because it was significantly faster on a local machine and allowed faster testing.
ninja
if errorlevel 1 exit /b 1

:: Install.
echo "Installing..."
ninja install
if errorlevel 1 exit /b 1

:: Error free exit.
echo "Error free exit!"
exit 0