#!/bin/bash

# eWaterCycle forecast running script
# Copies all needed files into the workdir of this job, then calls openda

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

#copy forcing ensemble to current working directory
ENSEMBLE_DIR=$IO_DIR/preprocess/ensemble
cp $ENSEMBLE_DIR/* .

#copy initial conditions to current working directory

INITIAL_DIR=$IO_DIR/initial
cp -r $INITIAL_DIR .

#copy pcrglobwb config to current working directory

PCRGLOBWB_CONFIG=$IO_DIR/forecast/pcrglobwb_config.ini
cp $PCRGLOBWB_CONFIG .

#copy openda config to current working directory
OPENDA_CONFIG_DIR=$IO_DIR/forecast/openda_config
cp -r $OPENDA_CONFIG_DIR .

#copy observations to openda observer folder
OBSERVATION_FILE=$IO_DIR/preprocess/h14_$ISO_DATE.nc
cp $OBSERVATION_FILE openda_config/stochObserver/h14_observations.nc

WORKDIR=$PWD

#start openda (assumes you have already setup openda previously)
cd $OPENDADIR

#we use a slightly changed version of oda_run that:
# - has "set -o errexit" defined to make sure cylc gets passed any error status
# - prints to the console instead of to a logfile
oda_run_console.sh $WORKDIR/openda_config/enkf-seq-threaded.oda


