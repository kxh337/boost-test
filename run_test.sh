#!/bin/bash
PROJ_DIR = ${1}
EXE_NAME = ${2}

if [ -d $PROJ_DIR]
then
    docker run -v $PROJ_DIR:/project -w /project -e "PROJ_DIR=$PROJ_DIR EXE_NAME=$EXE_NAME"
else
    echo "Error: $PROJ_DIR is not a directory"
fi
