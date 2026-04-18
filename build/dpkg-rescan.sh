#!/bin/bash

pushd .
cd tmp/deploy/deb
dpkg-scanpackages . | gzip -c9  > Packages.gz
popd
