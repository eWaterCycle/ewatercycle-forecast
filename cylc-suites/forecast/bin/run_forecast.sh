#!/bin/bash

# eWaterCycle forecast running script
# Copies all needed files into the workdir of this job, then calls openda

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

#copy observations to current working directory
OBSERVATION_FILE=$IO_DIR/preprocess/h14_$ISO_DATE.nc
cp $OBSERVATION_FILE h14_observations.nc

#copy forcing ensemble to current working directory
ENSEMBLE_DIR=$IO_DIR/preprocess/ensemble
cp $ENSEMBLE_DIR/* .

#copy initial conditions to current working directory

INITIAL_DIR=$IO_DIR/initial
cp -r $INITIAL_DIR .

#copy pcrglobwb config to current working directory

PCRGLOBW_CONFIG=$IO_DIR/forecast/pcrglobwb.ini
cp $PCRGLOBWB_CONFIG .

#copy openda config to current working directory
OPENDA_CONFIG_DIR=$IO_DIR/forecast/openda_config
cp -r $OPENDA_CONFIG_DIR .

#start openda


