#!/bin/sh
PROJ_DIR=$1
EXE_NAME=$2

# Configure
cmake $PROJ_DIR

# Build
cmake --build $PROJ_DIR
