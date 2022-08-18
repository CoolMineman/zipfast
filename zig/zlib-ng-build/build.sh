#!/usr/bin/env bash

# https://stackoverflow.com/a/242550
BASEDIR=$(dirname "$0")

cd "$BASEDIR" || exit
# cd ../../zlib-ng || exit
# git clean -d -f -x # remove files from previous build
# -DCMAKE_C_FLAGS_INIT="-fvisibility=hidden"
cmake -S ../../zlib-ng -B ./targets/"$1" -DCMAKE_TOOLCHAIN_FILE=../zig/zlib-ng-build/zig-toolchain.cmake -DBUILD_SHARED_LIBS=false -DZLIB_ENABLE_TESTS=false -DZIG_TARGET="$1" -DCMAKE_SYSTEM_NAME="$2"
cmake --build ./targets/"$1" --config Release
