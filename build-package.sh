#!/bin/bash

# build-package.sh builds and publishes the vimsanepkg.bpkg from current files
#

treqdrqs="drqs 108067799"  # A DRQS or TREQ associated with bpkg publication
thisVersion="$(cat version)"

bpkg_publish --ignore --version ${thisVersion} --${treqdrqs} --message "Updated vimsanepkg" ./vimsanepkg.pkgcfg


