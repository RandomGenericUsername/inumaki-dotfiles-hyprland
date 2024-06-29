#!/bin/bash


check_distro_support() {
  local distro_file="$1"

    # Check if the distribution file exists
    if [ ! -f "$distro_file" ]; then
        print "Distribution file $distro_file not found" error
        return 1
    fi

    # Read the current distribution ID_LIKE from /etc/os-release
    if [ -f /etc/os-release ]; then
        source /etc/os-release
    else
        print "Error: /etc/os-release not found" error
        return 1
    fi

    print "$ID_LIKE based distro detected" debug

    # Read supported distributions from the provided file
    local is_supported="false"
    local distro
    while read -r distro; do
        if [[ "$ID_LIKE" == *"$distro"* ]]; then
            is_supported="true"
            break
        fi
    done < "$distro_file"

    # Handle unsupported distributions
    if [ "$is_supported" != "true" ]; then
        print "Distribution $ID_LIKE is not supported" error
        print "Exiting..." debug
        return 2
    fi

    print "Distribution $ID_LIKE is supported" debug
    return 0
}
