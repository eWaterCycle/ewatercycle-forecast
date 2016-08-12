#!/bin/bash

# eWaterCycle forecast running script
# Copies all needed files into the workdir of this job, then calls openda

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

#copy openda config to current working directory
OPENDA_CONFIG_DIR=$IO_DIR/forecast/openda_config
cp -r $OPENDA_CONFIG_DIR .

#copy observations to openda config folder
OBSERVATION_FILE=$IO_DIR/preprocess/h14_$ISO_DATE.nc
cp $OBSERVATION_FILE openda_config/h14_observations.nc

#copy model
cp -r $PCRGLOBWB_MODEL_DIR PCR-GLOBWB

#needed for openda
mkdir model_template

PCRGLOBWB_CONFIG=$IO_DIR/forecast/pcrglobwb_config.ini
cp $PCRGLOBWB_CONFIG model_template

#As this for loop runs up to _and_including_ the given value, we
#Get an additional member (0) for the main OpenDA model
for ensembleMember in {0..$ENSEMBLE_MEMBER_COUNT}
do
    #also create a padded version of the number
    printf -v ensembleMemberPadded '%02d' $ensembleMember

    INSTANCE_DIR=work$ensembleMember
    mkdir $INSTANCE_DIR

    # copy config to instance
    cp $PCRGLOBWB_CONFIG $INSTANCE_DIR

    #copy initial state to instance
    ENSEMBLE_INITIAL_DIR="$IO_DIR/initial/state-member$ensembleMemberPadded"
    cp -r $ENSEMBLE_INITIAL_DIR $INSTANCE_DIR/initial

    #copy forcings to instance
    PRECIPITATION_FILE=$IO_DIR/preprocess/ensemble/precipEnsMem$ensembleMemberPadded.nc
    TEMPERATURE_FILE=$IO_DIR/preprocess/ensemble/tempEnsMem$ensembleMemberPadded.nc

    #Ensemble member 0 (the main model in OpenDA terms) does not need its own forcings as it is not actually run.
    #Borrow forcing files from member 01 so the model does not complain about lack of forcing files
    if [[ "$ensembleMember" -eq "0" ]]
    then
        PRECIPITATION_FILE=$IO_DIR/preprocess/ensemble/precipEnsMem01.nc
        TEMPERATURE_FILE=$IO_DIR/preprocess/ensemble/precipEnsMem01.nc
    fi


    cp $PRECIPITATION_FILE $INSTANCE_DIR/precipitation.nc
    cp $TEMPERATURE_FILE $INSTANCE_DIR/temperature.nc
done

#remember workdir
WORKDIR=$PWD

#set openda variables (as per install instructions)
export OPENDADIR=$OPENDA_LOCATION
export PATH=$OPENDADIR:$PATH
export OPENDA_NATIVE=linux64_gnu
export OPENDALIB=$OPENDADIR/$OPENDA_NATIVE/lib

cd $OPENDADIR

#We use a modified version of oda_run that:
# - Has "set -o errexit" defined to make sure cylc gets passed any error status
# - Prints to the console instead of to a logfile
# - Does not set LD_LIBRARY_PATH (causing conflics as it contains a lot of basic libraries such as sqlite and netcdf)
# - Sets java.library.path to still have native libraries available to OpenDA
oda_run_console.sh $WORKDIR/openda_config/enkf-seq-threaded.oda
