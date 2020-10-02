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
mkdir build
cd ./harness 
./setup.sh /phuzzers/AFLplusplus $binary
cd ../

# Remove soruce
cd ..
rm -rf ./harness

# Sets kernel options for AFL
echo core > /proc/sys/kernel/core_pattern
echo 1 > /proc/sys/kernel/sched_child_runs_first

# Make working dir
mkdir workdir
mkdir seed_dir

# run
python3 -m phuzzer -p AFL++ -c 1 -s $(pwd)/seed_dir "$(pwd)/build/$binary"
