#!/bin/bash

set -e 

mkdir build
export BUILD_DIR=${PWD}/build
export PATH=${BUILD_DIR}:$PATH
sudo apt-get install -y autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev tar
git clone https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --prefix=${BUILD_DIR} --enable-multilib
make -j`nproc`

${BUILD_DIR}/bin/riscv64-unknown-elf-gcc --version
if [[ $? == 0 ]]
then
  ${BUILD_DIR}/bin/riscv64-unknown-elf-gcc -print-multi-lib
else
  exit 1
fi
