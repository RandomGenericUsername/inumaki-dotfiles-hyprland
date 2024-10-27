#!/bin/bash

export PRINT_DEBUG_REPO="https://github.com/RandomGenericUsername/Print-debug-CLI.git"
export PRINT_DEBUG_BIN_NAME="print-debug"

__print_with_debug(){
    local msg="$@"
    if [[ "$ENABLE_DEBUG" == "true" ]];then
        printf "%b" "${DEBUG_COLOR}" 
        echo "DEBUG: [$msg]"
        printf "%b" "${NO_COLOR}" 
    fi
}

check_if_installed_print_debug_util() {
    local install_path="$1"
    if [[ -x "$install_path/$PRINT_DEBUG_BIN_NAME" ]]; then
        return 0
    else
        return 1
    fi
}

install_print_debug_util() {
    local install_path="$1"
    if check_if_installed_print_debug_util "$install_path"; then
        __print_with_debug "Print-debug utility is already installed at $install_path"
        return 0
    fi
    run "git clone $PRINT_DEBUG_REPO $install_path" || exit 1
    if ! check_if_installed_print_debug_util "$install_path"; then
        __print_with_debug "ERROR: Failed to install print-debug utility from $PRINT_DEBUG_REPO. Exiting."
        exit 1
    else
        __print_with_debug "Print-debug utility installed successfully at $install_path"
    fi  
}