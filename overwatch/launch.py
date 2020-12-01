#!/usr/bin/env python3

import subprocess
import threading
import os
from log import *
import sys

LOCK1 = False
LOCK2 = False

class phuzzer_start(threading.Thread):
    '''This will be the thread ran to start fuzzing the project.'''

    def __init__(self, git):
        '''Initialize the object with the git repo given and other attributes.'''
        self.stdout = None
        self.stderr = None
        threading.Thread.__init__(self)
        self.git = git

    def run(self):
        '''When thread called, begin fuzzing the git repo in docker.'''
        # Start proc
        command = [
            "/home/ubuntu/phuzzer_docker/run.sh",
            "chall.bin",
            f"{self.git}"
        ]
        print(command)
        os.chdir("/home/ubuntu/phuzzer_docker")

        p = subprocess.Popen(command, shell=False, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
        self.stdout, self.stderr = p.communicate()



# Check if we want debugging turned on
try:
    debug = sys.argv[1]
except:
    debug = False

while True:
    # Wait for file to be created
    if debug != False:
        LOGGER.info('Waiting for launch to exist..')
    while not os.path.exists("launch"):
        pass

    # Grab git repo
    if debug != False:
        LOGGER.info('Reading from launch file')
    git = open("launch","rb").read().decode()

    # Delete file
    if debug != False:
        LOGGER.info("Removing launch file")
    os.remove('launch')
    if debug != False:
        DEBUG.debug('Launch file removed!')

    # Create Thread
    phuzzer = phuzzer_start(git)
    if debug != False:
        LOGGER.info(f'Starting DRIFT thread on {git}')
    phuzzer.start()
    phuzzer.join()
    if debug != False:
        print(phuzzer.stdout.decode())
        print(phuzzer.stderr.decode())
