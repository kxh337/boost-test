#!/bin/sh
PROJ_DIR=$1
EXE_NAME=$2

cd $PROJ_DIR

# Build
cmake --build .

./$EXE_NAME
