#!/bin/bash

# Define global variables for commands
check_command=""
install_command=""
force_install_command=""


parse_packages_from_file() {
    local file="$1"
    local packages=()
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -z "$line" || "${line:0:1}" == "#" ]] && continue
        packages+=("$(envsubst <<< "$line")")
    done < "$file"
    echo "${packages[@]}"
}

install_packages_from_file() {
    local packages_file_path="$1"
    local force_install="${2:-false}"

    check_command="${PACKAGE_CHECKS[$BASE_DISTRO]}"
    install_command="${PACKAGE_MANAGERS_INSTALL_COMMANDS[$BASE_DISTRO]}"
    force_install_command="${PACKAGE_MANAGERS_FORCE_INSTALL_COMMANDS[$BASE_DISTRO]}"

    if [[ -z "$PACKAGE_MANAGER" || ! $(command -v "$PACKAGE_MANAGER") ]]; then
        $print_debug "Package manager '$PACKAGE_MANAGER' not found" -t "error"
        exit 1
    fi
    if [[ -z "$check_command" ]]; then
        $print_debug "No package check function found for distro '$BASE_DISTRO'" -t "error"
        exit 1
    fi
    if [[ -z "$install_command" ]]; then
        $print_debug "No package manager install command found for distro '$BASE_DISTRO'" -t "error"
        exit 1
    fi
    local packages;
    read -a packages -r <<< "$(parse_packages_from_file "$packages_file_path")"
    install_packages "${packages[@]}" "$force_install" || exit $?
}

is_installed() {
    local package="$1"
    $print_debug "Checking if package '$package' is installed: '$check_command $package'" -t "debug"
    $check_command "$package" &>/dev/null
    return $?
}

install_packages() {

    local force_install="${@: -1}" # Retrieve the last argument as force_install flag
    local packages=("${@:1:$(($#-1))}")   # Set `packages` to include all arguments except the last one (force_install flag)
    
    local install_cmd="$install_command"
    local to_install=()

    if [[ "$INSTALL_TYPE" == "clean" || "$force_install" == "true" ]]  &&  [[ -n "$force_install_command" ]]; then
        install_cmd="$force_install_command"
    fi

    for pkg in "${@:1:$(($#-1))}"; do
        if is_installed "$pkg"; then
            if [[ "$INSTALL_TYPE" == "clean" || "$force_install" == "true" ]]; then
                $print_debug "Package '$pkg' is already installed but will be reinstalled due to 'clean' installation." -t "debug"
                to_install+=("$pkg")
            else
                $print_debug "Package '$pkg' is already installed." -t "debug"
            fi
        else
            $print_debug "Package '$pkg' is not installed. Adding to installation list." -t "debug"
            to_install+=("$pkg")
        fi
    done

    if [[ ${#to_install[@]} -eq 0 ]]; then
        $print_debug "All packages are already installed" -t "debug"
        return 0
    fi
    $print_debug "Packages to install: ${to_install[*]}" -t "debug"
    $print_debug "Running : $install_cmd ${to_install[*]}" -t "debug"
    run "eval $install_cmd ${to_install[*]}"
}
