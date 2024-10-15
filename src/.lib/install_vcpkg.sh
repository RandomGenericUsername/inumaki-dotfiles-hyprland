check_vcpkg_installation() {
    local vcpkg_install_dir="$1"
    # Check if the vcpkg directory exists
    if [[ ! -d "$vcpkg_install_dir" ]]; then
        return 1  # Directory not found
    fi

    # Check if the vcpkg binary exists and is executable
    if [[ ! -x "$vcpkg_install_dir/vcpkg" ]]; then
        return 2  # Binary not found or not executable
    fi

    return 0  # vcpkg installation verified successfully
}

install_vcpkg() {
    local vcpkg_install_dir="$1"
    check_vcpkg_installation "$vcpkg_install_dir"
    local check_status=$?

    if [[ $check_status -eq 0 ]]; then
        $print_debug "vcpkg is already installed."
        return 0
    fi

    $print_debug "Cloning vcpkg repository on '$vcpkg_install_dir'" -t "debug"
    run "git clone $VCPKG_REPO $vcpkg_install_dir"

    $print_debug "Bootstrapping vcpkg..." -t "debug"
    cd "$vcpkg_install_dir" || exit 1
    run "./bootstrap-vcpkg.sh -disableMetrics"

    check_vcpkg_installation "$vcpkg_install_dir"
    local install_status=$?
    case $install_status in
        0)
            $print_debug "vcpkg installation verified successfully." -t "debug"
            ;;
        1)
            $print_debug "vcpkg installation directory not found at '$vcpkg_install_dir'. Installation may have failed." -t "error"
            exit 1
            ;;
        2)
            $print_debug "vcpkg binary not found or not executable. Please check permissions." -t "error"
            exit 1
            ;;
    esac

    $print_debug "Finished installing vcpkg..." -t "debug"
}
