#!/bin/bash

#save state to a single file

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

STATE_DIR=$IO_DIR/forecast/forecast/out-state
STATE_FILE=state.tar.gz

cp -r $STATE_DIR/* .

tar cvf $STATE_FILE *

cp $STATE_FILE $IO_DIR/postprocess/
