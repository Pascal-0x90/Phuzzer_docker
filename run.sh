#!/bin/bash

docker run -u "root" --privileged \
    -v "$(pwd)/src:/phuzzui" \
    -it pascal0x90/basic_phuzzer \
    /bin/bash -c "cd /phuzzui && ./startup.sh"
