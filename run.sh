#!/bin/bash

# Add name of binary
binary=$1
GIT_LOCATION=$2

# Run container
docker run -u "root" --privileged \
    -v "$(pwd)/src:/phuzzui" \
    -it pascal0x90/basic_phuzzer \
    /bin/bash -c "./startup.sh $binary $GIT_LOCATION"
