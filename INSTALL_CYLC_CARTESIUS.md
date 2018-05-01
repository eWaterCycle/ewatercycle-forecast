# Setting up CYLC workflow engine

## Support for graphical interface
This document details how to set up the graphical user interface on cartesius and (optionally) connect to it from the (linux) desktop.

### Setting up CYLC on cartesius
1. Setting up `${HOME}/.bashrc`:

```bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
module load graphviz

if [ -z ${LD_LIBRARY_PATH_ORIG+x} ]; then
  export LD_LIBRARY_PATH_ORIG=${LD_LIBRARY_PATH}
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH_ORIG}:${SURFSARA_LIBRARY_PATH}:${HOME}/local/usr/lib

if [ -z ${PKG_CONFIG_PATH_ORIG+x} ]; then
  export PKG_CONFIG_PATH_ORIG=${PKG_CONFIG_PATH}
fi
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH_ORIG}:/hpc/sw/graphviz-2.38.0/lib/pkgconfig

export CFLAGS="-I${HOME}/.local/usr/include -I${SARA_INCLUDE_PATH}"

export PATH=${HOME}/tools/cylc/bin:${HOME}/.local/usr/bin:$PATH
```
2. Source `${HOME}/.bashrc` or logout and log back in again.
3. Install pygraphviz for the graphical graph view:
``` bash
pip install --global-option=build_ext --global-option="-L/hpc/sw/graphviz-2.38.0/lib" pygraphviz --upgrade --force-reinstall --user
```
4. Download and install a recent [CYLC](https://github.com/cylc/cylc/releases) release. Extract the tarball and run make inside the target directory. Note that you may need to press enter a few times for errors building the documentation.
5. Create a symlink to the extracted directory so we don't need to update the PATH environment variable everytime we update CYLC (obviously the symlink needs to be changed in that case). To be consistent with the PATH defined in the `${HOME}/.bashrc` file defined at point 1:
```bash
mkdir ${HOME}/tools
ln -s ${HOME}/sources/cylc-${VERSION} ${HOME}/tools/cylc 
```
where `${VERSION}` is the version of CYLC installed.

6. Setting up CYLC environment variables for running the suites. CYLC does not use the environment defined in `${HOME}/.bashrc` anymore. Loading your modules, defining your variables and sourcing of your python virtual environment is done in `${HOME}/.cylc/job-init-env.sh`. Create this file and edit it for your situation.
7. Define your workflow suite in for example `${HOME}/cylc-suites/${SUITE}` where `${SUITE}` is the name of the CYLC suite.
8. Register CYLC suite. This can be either done from the desktop later or on cartesius using `cycl register`.
9. You should now be able to run the graphical frontend `gcylc` when logged in on cartesius if you are connected using `ssh -X` or `ssh -Y`.

### Setting up CYLC on your desktop
In order to connect to a CYLC suite on cartesius from your desktop, CYLC needs to be installed there as well. The following steps detail how to do this on a linux desktop.

1. Download CYLC and extract. Run make in the extracted directory. Optionally append to the `$PATH` environment variable as discussed above.
2. If `/usr/bin/env python` links to `python3` on your machine, run the following oneliner in the extracted directory:
```
# change /usr/bin/env python to /usr/bin/env python2 shebang
find ./ -type f | while read in ; do if file -i "${in}" | grep -q x-python ; then sed -i -e 's|/usr/bin/env python|/usr/bin/env python2|g' "${in}" ; fi ; done
```
3. Copy your public ssh key to cartesius `${HOME}/.ssh/authorized_keys`.
4. Make sure you can login without password using ssh-agent and ssh-add, see for example this [link](https://kb.iu.edu/d/aeww) for more details.
5. Launch the desktop application for your cartesius user:
```
${CYLC}/bin/gcylc --use-ssh --user=${USER} --host=cartesius.surfsara.nl --no-login
```

