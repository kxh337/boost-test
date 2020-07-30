#!/bin/bash
# Script to run the docker container application for the boost test
PROJ_DIR=$1
EXE_NAME=$2

if [ -d $PROJ_DIR ]
then
    sudo docker run boost-test:1.0 -v $PROJ_DIR:/project -e EXE_NAME=$EXE_NAME
else
    echo "Error: $PROJ_DIR is not a directory"
fi
