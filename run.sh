#!/bin/bash

docker run -u "root" --privileged \
    -v "$(pwd)/src:/phuzzui" \
    -it phuzzer \
    /bin/bash -c "cd /phuzzui && ./startup.sh"
