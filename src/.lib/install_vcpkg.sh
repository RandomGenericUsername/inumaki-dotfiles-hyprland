
check_vcpkg_installation() {
    local vcpkg_install_dir="$1"
    # Check if the vcpkg directory exists
    if [[ -d "$vcpkg_install_dir" ]]; then
        # Check if the vcpkg binary exists
        if [[ -f "$vcpkg_install_dir/vcpkg" ]]; then
            # Optionally, you can check if it's executable
            if [[ -x "$vcpkg_install_dir/vcpkg" ]]; then
                $print_debug "vcpkg installation verified successfully at '$vcpkg_install_dir'" -t "success"
                return 0
            else
                $print_debug "vcpkg is not executable. Please check permissions." -t "error"
                return 1
            fi
        else
            $print_debug "vcpkg binary not found. Installation may have failed." -t "error"
            return 1
        fi
    else
        $print_debug "vcpkg installation directory not found at '$vcpkg_install_dir'. Installation may have failed." -t "error"
        return 1
    fi
}


install_vcpkg(){
    local vcpkg_install_dir="$1"
    # Check if vcpkg is already installed
    if [ -d "$vcpkg_install_dir" ];then
        if [ -f "$vcpkg_install_dir/vcpkg" ]; then
            $print_debug "vcpkg is already installed at '$vcpkg_install_dir'" -t "debug"
            return 0
        fi
        rm -rf "$vcpkg_install_dir"
    fi
    $print_debug "Cloning vcpkg repository on '$vcpkg_install_dir'" -t "debug"

    run "git clone $VCPKG_REPO $vcpkg_install_dir"
        
    $print_debug "Bootstrapping vcpkg..." -t "debug"
    cd "$vcpkg_install_dir" || exit 1
    run "./bootstrap-vcpkg.sh -disableMetrics"
    check_vcpkg_installation "$vcpkg_install_dir"
    $print_debug "Finished installing vcpkg..." -t "debug"
}
