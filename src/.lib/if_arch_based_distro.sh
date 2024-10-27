if_arch_based_distro() {
    local distro
    distro="$(get_distro)"
    if [[ ! "$distro" == "arch" ]]; then
        return 1
    fi
    $print_debug "Arch-based distro detected. Installing yay package manager..." 
    install_yay || exit $?
}