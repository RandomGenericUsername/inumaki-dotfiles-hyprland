#!/bin/bash

check_date_h_installation() {
    local vcpkg_path="$1"
    # Check if date.h is installed by looking for it in the vcpkg installed packages list
    if $vcpkg_path/vcpkg list | grep -q '^date:'; then
        return 0  # date.h installation verified successfully
    else
        return 1  # date.h not found in vcpkg installed packages
    fi
}


install_date_h() {
    local vcpkg_path="$1"
    check_date_h_installation "$vcpkg_path"
    local check_status=$?

    if [[ $check_status -eq 0 ]]; then
        $print_debug "date.h is already installed."
        return 0
    fi

    $print_debug "Installing date.h using vcpkg at '$vcpkg_path'" -t "debug"
    run "$vcpkg_path/vcpkg install date"
    local install_status=$?

    if [[ $install_status -ne 0 ]]; then
        $print_debug "Failed to install date.h using vcpkg." -t "error"
        exit 1
    fi

    check_date_h_installation "$vcpkg_path"
    if [[ $? -eq 0 ]]; then
        $print_debug "date.h installation verified successfully." -t "debug"
    else
        $print_debug "date.h installation failed. It may not be properly installed." -t "error"
        exit 1
    fi

    $print_debug "Finished installing date.h..." -t "debug"
}
