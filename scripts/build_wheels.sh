#!/bin/bash

# this file is meant to be run inside the pypywheels docker image

set -e

TARGET=$1
TARGETDIR=/pypy-wheels/wheelhouse/$TARGET

packages=(
    cython
    netifaces
    psutil
    scipy
    pandas
    astropy
)

# Compile the wheels, for all pypys found inside /opt/
echo "Compiling wheels"
echo "TARGETDIR: $TARGETDIR"
mkdir -p $TARGETDIR
echo
cd

# First, NumPy wheels
for PYPY in /opt/pypy3.5-*/bin/pypy
do
    echo "FOUND PYPY: $PYPY"
    # pip install using our own wheel repo: this ensures that we don't
    # recompile a package if the wheel is already available.
    $PYPY -m pip install numpy \
          --extra-index https://juanlu001.github.io/pypy-wheels/$TARGET

    $PYPY -m pip wheel numpy \
          -w $TARGETDIR \
          --extra-index https://juanlu001.github.io/pypy-wheels/$TARGET
    echo
done

# Then, the rest
for PYPY in /opt/pypy3.5-*/bin/pypy
do
    echo "FOUND PYPY: $PYPY"
    # pip install using our own wheel repo: this ensures that we don't
    # recompile a package if the wheel is already available.
    $PYPY -m pip install "${packages[@]}" \
          --extra-index https://juanlu001.github.io/pypy-wheels/$TARGET

    $PYPY -m pip wheel "${packages[@]}" \
          -w $TARGETDIR \
          --extra-index https://juanlu001.github.io/pypy-wheels/$TARGET
    echo
done

echo "wheels copied:"
find $TARGETDIR -name '*.whl'
