#!/bin/bash

get_distro() {

    if [[ -z "${SUPPORTED_DISTROS+x}" || ${#SUPPORTED_DISTROS[@]} -eq 0 ]]; then
        echo "ERROR: ['SUPPORTED_DISTROS' is either unset or empty]"
        exit 1
    fi

    # Get ID and ID_LIKE from /etc/os-release
    local distro_id
    local distro_like
    distro_id=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
    distro_like=$(grep '^ID_LIKE=' /etc/os-release | cut -d'=' -f2 | tr -d '"')

    # Loop through SUPPORTED_DISTROS to check if either ID or ID_LIKE matches
    for base_distro in "${SUPPORTED_DISTROS[@]}"; do
        if [[ "$distro_like" == "$base_distro" || "$distro_id" == "$base_distro" ]]; then
            echo "$base_distro"
            return 0
        fi
    done

    # Return an empty string if no match found
    echo ""
}


check_distro(){

    # Get distro
    local distro
    distro="$(get_distro)"

    # Check if distro is supported
    if [[ -z "$distro" ]]; then
        echo "ERROR: [Distro not supported.]"
        exit 1
    fi
    echo "$distro"
}

get_package_manager() {
    local base_distro
    base_distro="$(check_distro)"

    # Verify that the base_distro is not empty and has an associated package manager
    if [[ -n "$base_distro" && -n "${PACKAGE_MANAGERS[$base_distro]+x}" ]]; then
        export PACKAGE_MANAGER="${PACKAGE_MANAGERS[$base_distro]}"
    else
        echo "Error: Package manager not defined for distribution '$base_distro'"
        return 1
    fi
}

