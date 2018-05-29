#!/bin/bash

# eWaterCycle download script for soil moisture observations.
#
# uses environment variables:
#     ISO_DATE, for date to download
#     IO_DIR, for location of shared state files for this cycle

#stop the script if we use an unset variable, or a command fails
set -o nounset -o errexit

#download bz2 file, uses credentials as specified in ~/.netrc
wget ftp://ftphsaf.meteoam.it/h14/h14_cur_mon_grib/h14_${ISO_DATE}_0000.grib.bz2

cp h14_${ISO_DATE}_0000.grib.bz2 $IO_DIR/download/
