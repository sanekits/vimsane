#!/bin/bash

# build-package.sh builds and publishes the vimsanepkg.bpkg from current files
#

treqdrqs="drqs 108067799"  # A DRQS or TREQ associated with bpkg publication
thisVersion="$(cat version)"

function errExit {
    echo "ERROR: $*" >&2
    exit 1
}

if [[ "" != $(git status --porcelain) ]]; then
    errExit "Git status says you have uncommitted files.  Sorry."
fi

function makeBuildInfo {
    echo "git_hash: $(git rev-parse HEAD)"
    echo "git_branch: $(git rev-parse --abbrev-ref HEAD)"
    echo "build_dir: $PWD"
    echo "git_origin: $(git config --get remote.origin.url)"
    echo "build_date: $(date)"
    echo "build_user: $USER"
}

makeBuildInfo > buildinfo

bpkg_publish --ignore --version ${thisVersion} --${treqdrqs} --message "Updated vimsanepkg" ./vimsanepkg.pkgcfg


