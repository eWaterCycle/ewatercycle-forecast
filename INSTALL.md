# Install Guide for eWaterCycle

## Prerequisites
eWaterCycle is a system build from pre-exisiting open source components. To run the eWaterCycle system, each of these components will have to be installed on your local hardware. First, all pre-requisite software and libraries need to be installed.

On machines running Ubuntu 16.04, the following packages are available in the package management system:
- Python
- GDAL
- Java
- CDO
- NCL

### PCRGlobWB (custom version?) (inc. GDAL)
The PCRGlobWB hydrological model at the core of eWaterCycle is written in python. For PCRGlobWB to run first python, PCRaster and GDAL need to be installed.
#### python
PCRGlobWB and PCRaster require python version 2.7. Install Python from https://www.python.org/
#### PCRaster
PCRaster installation guide can be found on the PCRaster website: http://pcraster.geo.uu.nl/getting-started/pcraster-on-linux/installation-linux/
#### GDAL
PCRaster uses the Geospatial Data Abstraction Library (GDAL). To install GDAL, go to http://www.gdal.org/ 

### OpenDA (custom version?)
Download and install OpenDA using the installation guide on FOOBAR LINK TO THE CORRECT PAGE.
#### Java
OpenDA does requires Java to present on your computer. If not already installed, install java via https://java.com/en/download/

### CDO
the Climate Data Operators (CDO) toolbox provides a number of tools that work on GRIB or NetCDF files. Install the toolbox for your specific machine using the guide at https://code.zmaw.de/projects/cdo/wiki/cdo. Make sure to also install the Libs4CDO extension, which provides support for NetCDF files: https://code.zmaw.de/projects/cdo/wiki/Libs4cdo.

### NCL
The NCAR Climate Language (NLC) library of command line tools to work on climate related data is used to convert data from grib files to NetCDF. It can be downloaded and installed from http://www.ncl.ucar.edu/

### Cylc
The Cylc workflow engine orchestrates the entire eWaterCycle system. Install Cylc from https://cylc.github.io/cylc/. Cylc also needs python, just as PCRGlobWB.

## getting data.
the eWaterCycle has three main data inputs that it needs. Two change on daily basis: the weather forecast (GEFS from NCEP), observations of soil moisture (SM-DAS from HSAF). The third data input is a set of fixed maps with parameters that PCRGlobWB needs.
### GEFS
The GEFS weather forecast is downloaded automatically by the pre-processor and no further action is needed.

### SM-DAS
The SM-DAS soil moisture observations are also downloaded automatically. However, one has to register with HSAF to be allowed to download the data. To register, follow the stept on http://hsaf.meteoam.it/user-registration.php. The username and password provided to you are needed in the installation step, below.

### PCRGlobWB input
When running PCRGlobWB globally, the input files needed can be downloaded from FOOBAR SITE. 

## installing and configuring eWaterCycle
FOOBAR

## running  eWaterCycle
FOOBAR
