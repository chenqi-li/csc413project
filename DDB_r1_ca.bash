#!/bin/bash

COMPRESSION=$1
OUTPUT=/home/results/$COMPRESSION

#? Convert dataset

#? Train
ARGS="--work-dir $OUTPUT"
cd /home/submodules/DDB
bash tools/dist_train.sh configs/gta2city/$COMPRESSION/r1_st_ca_dlv2_r101v1c_2x2_512x512_20k_gta2city.py 2 \
    $ARGS
