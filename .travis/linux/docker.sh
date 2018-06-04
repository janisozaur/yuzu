#!/bin/bash -ex

apt-get update
apt-get install -y build-essential git libqt5opengl5-dev libsdl2-dev libssl-dev python qtbase5-dev wget ccache cmake

cd /yuzu

mkdir build && cd build
ccache --show-stats > ccache_before
cmake .. -DYUZU_BUILD_UNICORN=ON -DCMAKE_BUILD_TYPE=Release
make -j4
ccache --show-stats > ccache_after
diff -U100 ccache_before ccache_after || true

ctest -VV -C Release
