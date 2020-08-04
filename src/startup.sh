#!/bin/bash

# fix python
rm /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python

# fix phuzzer
cd /usr/local/lib/python3.6/dist-packages/phuzzer 
git init
cd ..
git apply /phuzzui/drift.patch
cd /phuzzui/src

# Take in name of binary
binary=$1

# Take in git repo
GIT_LOCATION=$2

# Get the harness
git clone $GIT_LOCATION harness 

# Compile binary
cd ./harness 
./setup.sh /usr/local/bin/afl-unix/
cd ../

# Sets kernel options for AFL
echo core > /proc/sys/kernel/core_pattern
echo 1 > /proc/sys/kernel/sched_child_runs_first

# run
python3 -m phuzzer -c 1 -s ./seed_dir "$(pwd)/harness/build/$binary"
