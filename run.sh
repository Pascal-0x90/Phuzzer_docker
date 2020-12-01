#!/bin/bash

# Add name of binary
binary=$1
GIT_LOCATION=$2

echo "Running with git location:"
echo $GIT_LOCATION
echo "Using binary name:"
echo $binary

# Run container
docker run -u "root" --privileged \
    -v "$(pwd)/arena:/phuzzui" \
    -it pascal0x90/basic_phuzzer \
    /bin/bash -c "./startup.sh $binary $GIT_LOCATION"
