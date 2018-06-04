#!/bin/bash -ex

set -o pipefail

export MACOSX_DEPLOYMENT_TARGET=10.12
export Qt5_DIR=$(brew --prefix)/opt/qt5
export UNICORNDIR=$(pwd)/externals/unicorn

ls /opt/libexec
mkdir build && cd build
export PATH=/opt/libexec:$PATH
ccache --show-stats > ccache_before
cmake --version
cmake .. -DYUZU_BUILD_UNICORN=ON -DCMAKE_BUILD_TYPE=Release
make -j4
ccache --show-stats > ccache_after
diff -U100 ccache_before ccache_after || true

ctest -VV -C Release
