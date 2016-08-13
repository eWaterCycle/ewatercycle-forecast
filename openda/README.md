This folder contains a small patch for OpenDA to make it compatible with eWaterCycle. All of these should be handled better than the oneliner workarounds we introduced. Thus, we keep them here as a patch. This patch should not be needed in a (near) future version of the eWaterCycle software, we hope.

The patch was created against revision 553 of the OpenDA svn repo ( https://svn.oss.deltares.nl/repos/openda/trunk )

Changes:

- Do not create or remove work directories for each model instance in bmi_model. The eWaterCycle forecast suite fills these itself.
- Tolerate missing values in the model at observation points. Due to some rescaling issues in OpenDA, there are some (1200 out of 600.000) model points "lost" in rescaling (on edges of the map and model). OpenDA normally exits on a NaN in the model at an observed point. We "fix" this by setting the value to 0 (a not unlikely value for our model).
- The BMI Model Buffer Exchange items suffer from a NullPointerExceptioni, most likely as the model is run after the last DA step.


Obtaining the OpenDA

OpenDA can be downloaded from openda.org (create an account for svn access)

The eWatercycle version of OpenDA can be create by executing the following commands:

```
$ svn export -r 553 https://svn.oss.deltares.nl/repos/openda/trunk openda
$ cd openda
$ patch -p0 < ~/ewatercycle/ewatercycle/openda/openda.patch 
$ ant build
```

The patched version is also available in Zenodo at 
