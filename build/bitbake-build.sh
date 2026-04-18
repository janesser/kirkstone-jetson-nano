#!/bin/bash

#bitbake libglvnd tegra-libraries-gbm tegra-libraries-core
bitbake world --runall=fetch -k
bitbake core-image-x11
