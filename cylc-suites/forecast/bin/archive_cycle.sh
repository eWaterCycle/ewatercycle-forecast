#!/bin/bash

#archive the result and intermediate shared state of the cycle

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

mkdir -p $ARCHIVE_DIR

ARCHIVE_FILE=$ARCHIVE_DIR/$CYLC_TASK_CYCLE_POINT.tar.gz

cd $CYLC_SUITE_SHARE_DIR
tar zcvf $ARCHIVE_FILE $CYLC_TASK_CYCLE_POINT
