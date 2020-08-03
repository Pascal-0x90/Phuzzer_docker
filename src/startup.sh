#!/bin/bash

# Take in name of binary
binary=$1

# Take in git repo
GIT_LOCATION=$2

# Compile binary
./setup.sh /usr/local/bin/afl-unix $GIT_LOCATION

# Sets kernel options for AFL
echo core > /proc/sys/kernel/core_pattern
echo 1 > /proc/sys/kernel/sched_child_runs_first

# run
python3 -m phuzzer -t 30 -c 4 -d 2 "$(pwd)/build/$binary"
