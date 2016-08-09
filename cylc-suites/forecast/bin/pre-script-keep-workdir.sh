#!/bin/bash

# eWaterCycle pre script.

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

#do not clean working dir
#rm -rf $CYLC_TASK_WORK_DIR/*

#created shared state dirs for this cycle point
mkdir -p $IO_DIR
mkdir -p $IO_DIR/download
mkdir -p $IO_DIR/preprocess
mkdir -p $IO_DIR/forecast
mkdir -p $IO_DIR/output

