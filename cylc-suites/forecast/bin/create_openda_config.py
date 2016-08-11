#!/usr/bin/env python

import os
import sys
import shutil


# Generate OpenDA configuration by doing a simple search-and-replace on a configuration template.
# Crude but effective.

def search_and_replace(infilename, outfilename, replacements):
    infile = open(infilename)
    outfile = open(outfilename, 'w')

    # replace each replacement in turn for each line
    for line in infile:
        for src, target in replacements.iteritems():
            if target is None:
                print "ERROR: %s was not defined" % src
                sys.exit(1)
            line = line.replace(src, target)
        outfile.write(line)
    infile.close()
    outfile.close()


if __name__ == '__main__':

    # input and output files
    config_template_dir = os.getenv('CONFIG_TEMPLATE_DIR')

    if config_template_dir is None:
        print "ERROR: configuration template dir not defined"
        sys.exit(1)

    io_dir = os.getenv("IO_DIR")

    if not os.path.isdir(io_dir):
        print "IO dir does not exist"
        exit(1)

    result_dir = 'openda_config'

    #copy entire template folder
    shutil.copytree(config_template_dir, result_dir)

    # inputdirectory = os.getenv('INPUTDIR')
    # outputdirectory = "output"
    # starttime = os.getenv('STARTTIME')
    # endtime = os.getenv('ENDTIME')
    # precipitationfile = "precipitation.nc"
    # temperaturefile = "temperature.nc"
    # initialconditionsdir = "initial"
    #
    # replacements = {'INPUTDIR': inputdirectory, 'OUTPUTDIR': outputdirectory, 'STARTTIME': starttime,
    #                  'ENDTIME': endtime, 'PRECIPITATIONFILE': precipitationfile, 'TEMPERATUREFILE': temperaturefile,
    #                  'INITIALCONDITIONSDIR': initialconditionsdir}
    #
    # search_and_replace(config_template, result_file, replacements)

    io_output_dir = os.path.join(io_dir, 'forecast', result_dir)

    if os.path.isdir(io_output_dir):
        shutil.rmtree(io_output_dir)

    shutil.copytree(result_dir, io_output_dir)
