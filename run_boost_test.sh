#!/bin/sh
# script called by the Docker container to run all the builds and run the tests

# Directory containing all of the test suites
PROJ_DIR=$1

# Get list of all directories
EXE_NAME=$2

cd $PROJ_DIR

# Build all projects
cmake --build .

# Run all tests on projects
./$EXE_NAME
