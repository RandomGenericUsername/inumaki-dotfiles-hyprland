#!/bin/bash

declare -A ARG_VALUES
declare -A ARG_MULTI_VALUES
DEBUG=false

# Function to print debug messages
debug() {
    if $DEBUG; then
        echo "$@"
    fi
}

# Function to parse arguments
parse_args() {
    while [[ "$#" -gt 0 ]]; do
        local array_name="$1"
        local var_name="$2"
        shift 2

        debug "Parsing options for array: $array_name, Variable: $var_name"

        # Use indirect reference to access the array
        eval "local -a options=(\"\${${array_name}[@]}\")"

        for opt in "${options[@]}"; do
            debug "Mapping option $opt to variable $var_name"
            ARG_VALUES["$opt"]="$var_name"
            ARG_MULTI_VALUES["$opt"]=false
        done
    done

    debug "Parsed ARG_VALUES:"
    for key in "${!ARG_VALUES[@]}"; do
        debug "$key -> ${ARG_VALUES[$key]}"
    done
}

# Function to enable multi-value for specific arguments
enable_multi_value() {
    while [[ "$#" -gt 0 ]]; do
        local option="$1"
        shift

        if [[ -n "${ARG_VALUES[$option]}" ]]; then
            ARG_MULTI_VALUES["$option"]=true
        else
            echo "Error: $option is not a recognized option"
            exit 1
        fi
    done
}

# Function to parse the command line arguments
parse_command_line() {
    debug "Parsing command line arguments..."
    while [[ "$#" -gt 0 ]]; do
        if [[ "$1" == "-d" || "$1" == "--debug" ]]; then
            DEBUG=true
            shift
            continue
        fi
        debug "Current argument: $1"
        if [[ -n "${ARG_VALUES[$1]}" ]]; then
            local var_name="${ARG_VALUES[$1]}"
            local multi_value="${ARG_MULTI_VALUES[$1]}"
            debug "Matched option $1 to variable $var_name"
            shift
            if [[ "$multi_value" == true ]]; then
                eval "$var_name=()"
                while [[ -n "$1" && "$1" != -* ]]; do
                    eval "$var_name+=(\"$1\")"
                    debug "Added $1 to $var_name"
                    shift
                done
            else
                if [ -n "$1" ] && [ "${1:0:1}" != "-" ]; then
                    eval "$var_name=\"$1\""
                    debug "Set $var_name to $1"
                    shift
                else
                    echo "Error: $1 requires a non-empty argument."
                    exit 1
                fi
            fi
        else
            debug "Skipping unknown argument $1"
            shift
        fi
    done
}

# Function to get the value of a parsed argument
get_arg_value() {
    local var_name=$1
    debug "Getting value of $var_name"
    if [[ "$(declare -p $var_name 2>/dev/null)" =~ "declare -a" ]]; then
        eval "echo \${$var_name[@]}"
    else
        echo "${!var_name}"
    fi
}
