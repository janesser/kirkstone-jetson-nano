#!/bin/bash

pushd .
cd $(dirname "$0")

cd meta-tegra
git checkout -t origin/kirkstone-l4t-r32.7.x
git pull

cd ../openembedded-core
git checkout -t origin/kirkstone
git pull

cd ../poky
git checkout -t origin/kirkstone
git pull

popd
