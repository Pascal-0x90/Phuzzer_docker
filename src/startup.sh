#!/bin/bash

# Compile binary
gcc chall.bin.c -o chall.bin

# Sets kernel options for AFL
echo core > /proc/sys/kernel/core_pattern
echo 1 > /proc/sys/kernel/sched_child_runs_first

# run
python3 -m phuzzer -c 4 -d 2 "$(pwd)/chall.bin"
