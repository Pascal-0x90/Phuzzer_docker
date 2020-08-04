#!/bin/bash

# fix python
rm /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python

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
python3 -m phuzzer -t 30 -c 4 -d 2 "$(pwd)/harness/build/$binary"
