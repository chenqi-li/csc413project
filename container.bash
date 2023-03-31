#!/bin/bash

DRIVE=$1

VOLUMES="--volume=${PWD}/misc:/home/misc
        --volume=${PWD}/src:/home/src
        --volume=${PWD}/submodules:/home/submodules
        --volume=${PWD}/results:/home/results
        --volume=${1}:/home/data"

GPU_1='"device=1"'

sudo docker run \
-it \
-p 6006:6006 \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
--gpus all \
--shm-size 32G \
$VOLUMES \
--name=csc413 \
csc413

# Run the following before docker run to allow x server connection
# xhost +local:root