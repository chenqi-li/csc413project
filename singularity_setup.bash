#! /bin/bash

DOCKER_NAME=csc413

# docker run -d -p 5000:5000 --restart=always --name registry registry:2
sudo docker start registry
sudo docker tag $DOCKER_NAME localhost:5000/$DOCKER_NAME
sudo docker push localhost:5000/$DOCKER_NAME

SINGULARITY_NOHTTPS=1 singularity build -f -F misc/$DOCKER_NAME.sif $DOCKER_NAME.def