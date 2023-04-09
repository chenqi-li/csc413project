#!/bin/bash

COMPRESSION=$1
OUTPUT=/home/results/$COMPRESSION

cd /home/submodules/DDB

#? Convert dataset
python3 tools/convert_datasets/gta.py /home/data/gta > /dev/null
python tools/convert_datasets/cityscapes.py /home/data/cityscapes > /dev/null

#? Train
ARGS="--work-dir $OUTPUT"
bash tools/dist_train.sh configs/gta2city/$COMPRESSION/r1_st_cu_dlv2_r101v1c_2x2_512x512_20k_gta2city.py 2 \
    $ARGS