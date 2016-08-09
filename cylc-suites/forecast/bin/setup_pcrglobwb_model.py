#!/usr/bin/env python

import os
import sys

template=os.getenv('TEMPLATE')

outputdirectory=os.getenv('OUTPUTDIRECTORY', "Nothing")
starttime=os.getenv('STARTTIME', "Nothing")
endtime=os.getenv('ENDTIME', "Nothing")
precipitationfile=os.getenv('PRECIPITATIONFILE', "Nothing")
temperaturefile=os.getenv('TEMPERATUREFILE', "Nothing")
initialconditionsdir=os.getenv('INITIALCONDITIONSDIR', "Nothing")

infile = open(template)
outfile = open(template + '.out', 'w')

replacements = {'OUTPUTDIRECTORY':outputdirectory, 'STARTTIME':starttime, 'ENDTIME':endtime, 'PRECIPITATIONFILE':precipitationfile, 'TEMPERATUREFILE':temperaturefile, 'INITIALCONDITIONSDIR':initialconditionsdir}

for line in infile:
    for src, target in replacements.iteritems():
        line = line.replace(src, target)
    outfile.write(line)
infile.close()
outfile.close()

