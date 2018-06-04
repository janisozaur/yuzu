#!/bin/bash -ex

apt-get update
apt-get install -y build-essential git libqt5opengl5-dev libsdl2-dev libssl-dev python qtbase5-dev wget cmake

cd /yuzu

mkdir build && cd build
cmake .. -DYUZU_BUILD_UNICORN=ON -DCMAKE_BUILD_TYPE=Release
make -j4

ctest -VV -C Release
