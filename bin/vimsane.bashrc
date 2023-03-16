# vimsane.bashrc - shell init file for vimsane sourced from ~/.bashrc

vimsane-semaphore() {
    [[ 1 -eq  1 ]]
}

command -v vim &>/dev/null || {
    vim() {
        command vi "$@"
    }
}
