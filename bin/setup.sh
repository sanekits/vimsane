#!/bin/bash
# setup.sh for vimsane
#  This script is run from a temp dir after the self-install code has
# extracted the install files.   The default behavior is provided
# by the main_base() call, but after that you can add your own logic
# and installation steps.

canonpath() {
    builtin type -t realpath.sh &>/dev/null && {
        realpath.sh -f "$@"
        return
    }
    builtin type -t readlink &>/dev/null && {
        command readlink -f "$@"
        return
    }
    # Fallback: Ok for rough work only, does not handle some corner cases:
    ( builtin cd -L -- "$(command dirname -- $0)"; builtin echo "$(command pwd -P)/$(command basename -- $0)" )
}

stub() {
   builtin echo "  <<< STUB[$*] >>> " >&2
}
scriptName="$(canonpath  $0)"
scriptDir=$(command dirname -- "${scriptName}")

source ${scriptDir}/shellkit/setup-base.sh

die() {
    builtin echo "ERROR(setup.sh): $*" >&2
    builtin exit 1
}

main() {
    Script=${scriptName} main_base "$@"
    builtin cd ${HOME}/.local/bin || die 208

    which git &>/dev/null || die "git not installed or not on PATH"

    tarfile=${PWD}/vimsane/vimsane-cfg.tgz
    tmp_d=$(mktemp -d);
    pushd ${tmp_d} &>/dev/null || die 31
    trap '[[ -d ${tmp_d} ]] && rm -rf ${tmp_d}' exit
    tar -xvzf ${tarfile} || die 32
    mkdir -p ${HOME}/.vim ${HOME}/.vimtmp
    cd ${HOME}/.vim || die 209
    cp -ru ${tmp_d}/vimsane-cfg/. ./ || die 210
    [[ -d Vundle.vim/.git ]] || {
        git clone "https://github.com/VundleVim/Vundle.vim.git" || die 211
    }
    ln -sf load-lmath-plugins.vim load-plugins.vim
    ln -sf lmath-vimrc.vim vimrc

    VIMHOME=${PWD} vim +PluginInstall +qall

    popd &>/dev/null

    # FINALIZE: perms on ~/.local/bin/vimsane.  We want others/group to be
    # able to traverse dirs and exec scripts, so that a source installation can
    # be replicated to a dest from the same file system (e.g. docker containers,
    # nfs-mounted home nets, etc)
    command chmod og+rX ${HOME}/.local/bin/${Kitname} -R
    command chmod og+rX ${HOME}/.local ${HOME}/.local/bin
    true
}

[[ -z ${sourceMe} ]] && {
    main "$@"
    builtin exit
}
command true
