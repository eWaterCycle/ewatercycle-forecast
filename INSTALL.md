# Install Guide for eWaterCycle

## Prerequisites
eWaterCycle is a system build from pre-exisiting open source components. To run the eWaterCycle system, each of these components will have to be installed on your local hardware. First, all pre-requisite software and libraries need to be installed.

On machines running Ubuntu 16.04, the following packages are available in the package management system:
- Python
- GDAL
- Java
- CDO
- NCL
- NCO

### PCRGlobWB (custom version?) (inc. GDAL)
The PCRGlobWB hydrological model at the core of eWaterCycle is written in python. For PCRGlobWB to run first python, PCRaster and GDAL need to be installed.
#### python
PCRGlobWB and PCRaster require python version 2.7. Install Python from https://www.python.org/
#### PCRaster
PCRaster installation guide can be found on the PCRaster website: http://pcraster.geo.uu.nl/getting-started/pcraster-on-linux/installation-linux/
#### GDAL
PCRaster uses the Geospatial Data Abstraction Library (GDAL). To install GDAL, go to http://www.gdal.org/ 

### OpenDA (with some patches)

The eWaterCycle uses a slighly patched version of OpenDA, the Open Data Assimilation toolbox. See http://openda.org for more information and documentation on OpenDA, see the openda folder in this repo for the patches needed.

#### Java
OpenDA does requires Java to present on your computer. If not already installed, install java via https://java.com/en/download/

### CDO
the Climate Data Operators (CDO) toolbox provides a number of tools that work on GRIB or NetCDF files. Install the toolbox for your specific machine using the guide at https://code.zmaw.de/projects/cdo/wiki/cdo. Make sure to also install the Libs4CDO extension, which provides support for NetCDF files: https://code.zmaw.de/projects/cdo/wiki/Libs4cdo.

### NCL
The NCAR Climate Language (NLC) library of command line tools to work on climate related data is used to convert data from grib files to NetCDF. It can be downloaded and installed from http://www.ncl.ucar.edu/

### NCO

NetCDF Operator (NCO) is used for a few operations where CDO fails to function properly. Install it from http://nco.sourceforge.net

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

## running eWaterCycle

The main ewatercycle (this repo) includes all the neccesairy scripts to run the eWaterCycle forecast. Using Cylc, register the suite in cylc-suites/forecast. You will also need to create a settings.rc file there. There is an settings.rc.example file included that should already suffice for most users. This settings files assumes all needed data and software is present in a "ewatercycle" folder in the users home dir:

- initial_state.tar.gz file with initial conditions for the first forecast day
- openda
- PCRGlobWB
- hydroworld dataset (containing parameter files used by PCRGlobWB)

In addition, the hsaf credentials should be put in a file containing a single line with format e.mail%40domain.com:p3ssw3rd. The default location for this file is $HOME/.hsaf_credentials

The example settings use a low resolution version of the model (30 arc minutes, or about 50km grid cell size). This should allow a user to run the model on a modest workstation. The main requirement is memory, with around 20Gb needed. If there is not enough memory available a simple solution is to reduce the number of ensemble members. Though note that the result will also be of much lower quality in this case.

Once all the needed software and data is there, running the forecast should be relatively straightforward by running the suite using Cylc.

Running the higher resolution model requires a lot more memory. The suite includes the settings file for the higher resolution model. Note that some parts will still use a lower resolution (for instance the data assimilation) due to performance and memory problems.
