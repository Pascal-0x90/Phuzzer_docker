#!/bin/bash

AFL_LOCATION=$1
GIT_LOCATION=$2

# Make sure there is a build dir
mkdir build

# Git clone and cd
git clone $GIT_LOCATION harness && cd harness

# Start compilation
gcc chall.bin.c -o ../build/chall.bin

# Remove soruce
cd ..
rm -rf ./harness
