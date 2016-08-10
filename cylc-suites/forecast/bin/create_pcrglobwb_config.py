#!/usr/bin/env python

import os
import sys
import shutil

#Generate PCRGlob-WB configuration by doing a simple search-and-replace on a configuration template.
#Crude but effective, should be adaptable to work for most models.

#input template (set in environment by Cylc)
config_template=os.getenv('CONFIG_TEMPLATE')

if config_template is None:
    print "ERROR: configuration template not defined"
    sys.exit(1)

#output folder (set in environment by Cylc)
io_dir = os.getenv("IO_DIR")

if not os.path.isdir(io_dir):
    print "IO dir does not exist"
    exit(1)

result_file = 'pcrglobwb_config.ini'

#values in templates that can be replaced. Some actually a constant here, some set from Cylc.
inputdirectory=os.getenv('INPUTDIR')
outputdirectory="output"
starttime=os.getenv('STARTTIME')
endtime=os.getenv('ENDTIME')
precipitationfile="precipitation.nc"
temperaturefile="temperature.nc"
initialconditionsdir="initial"

#dict with all replacements
replacements = {'INPUTDIR':inputdirectory,'OUTPUTDIR':outputdirectory, 'STARTTIME':starttime, 'ENDTIME':endtime, 'PRECIPITATIONFILE':precipitationfile, 'TEMPERATUREFILE':temperaturefile, 'INITIALCONDITIONSDIR':initialconditionsdir}

infile = open(config_template)
outfile = open(result_file, 'w')

#replace each replacement in turn for each line
for line in infile:
    for src, target in replacements.iteritems():
        if target is None:
            print "ERROR: %s was not defined" % src
            sys.exit(1)
        line = line.replace(src, target)
    outfile.write(line)
infile.close()
outfile.close()


#copy output to final output folder
io_output_dir = os.path.join(io_dir, 'forecast')
shutil.copy(result_file, io_output_dir)
