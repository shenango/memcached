#!/bin/bash

## This script will help you to download arachne-all and build memcached
INSTALL_PREFIX=/usr/local/memcached-A # Change this to your installation directory

# First, recursively clone Arachne super repository inside memcached top level
# directory.
MEMCACHED_DIR=$(dirname $(dirname $(readlink -f $0)))
cd $MEMCACHED_DIR

ARACHNE_DIR=${MEMCACHED_DIR}/arachne-all
echo "Installing arachne-all to ${ARACHNE_DIR}"

pushd arachne-all

git clone https://github.com/PlatformLab/Arachne.git
pushd Arachne
git checkout 3ce620af12b6013d49491742d94560e08504579e
popd

git clone https://github.com/PlatformLab/ArachnePerfTests.git
pushd ArachnePerfTests
git checkout 8ebd283beec910d133add6f8a148eca4186eb327
popd

git clone https://github.com/PlatformLab/CoreArbiter.git
pushd CoreArbiter
git checkout 6c7b6e3992c7996267ccca8a338e73b59a6d36a1
popd

git clone https://github.com/google/googletest.git
pushd googletest
git checkout 4bab34d2084259cba67f3bfb51217c10d606e175
popd

git clone https://github.com/PlatformLab/PerfUtils.git
pushd PerfUtils
git checkout 1de07f3e956cc4d679220cac9016710f33c054be
popd

./buildAll.sh
popd

# Second, buidl memcached-A itself
echo "Compiling memcached-A"
./autogen.sh
./configure --prefix=${INSTALL_PREFIX}
make -j16
