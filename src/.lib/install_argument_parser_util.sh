#!/bin/bash

export ARGUMENT_PARSER_UTIL_REPO="https://github.com/RandomGenericUsername/Bash-scripting-argument-parser.git"
export ARGUMENT_PARSER_BIN_NAME="argument-parser"

check_if_installed_argument_parser_util() {
    local install_path="$1"
    if [[ -x "$install_path/$ARGUMENT_PARSER_BIN_NAME" ]]; then
        return 0
    else
        return 1
    fi
}

install_argument_parser_util() {
    local install_path="$1"
    if check_if_installed_print_debug_util "$install_path"; then
        $print_debug "Argument parser utility is already installed at $install_path"
        return 0
    fi
    run "git clone $ARGUMENT_PARSER_UTIL_REPO $install_path" || exit 1
    if ! check_if_installed_argument_parser_util "$install_path"; then
        $print_debug "Failed to install argument parser utility from $ARGUMENT_PARSER_UTIL_REPO. Exiting."
        exit 1
    else
        $print_debug "Argument parser utility installed successfully at $install_path"
    fi  
}