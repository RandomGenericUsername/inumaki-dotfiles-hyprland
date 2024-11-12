#!/bin/bash

print_debug_script="{{cookiecutter.PRINT_DEBUG_UTIL}}"


get_variable(){
    local variable="$1"
    local file="{{cookiecutter.DOTFILES_METADATA}}"
    if [[ -z "$variable" ]]; then
        $print_debug_script "No variable passed." -t "error"
        return 1
    fi
    if [[ ! -f "$file" ]]; then
        $print_debug_script "No valid metadata file found at $file" -t "error"
        return 1
    fi
    
    # Use tomlq to get the value based on the provided path
    local value; value=$(tomlq ".${variable}" "$file" 2>/dev/null | xargs)
    local status=$?
    
     # If tomlq returns null, treat it as an unset variable and return an empty string
    if [[ $status -ne 0 || "$value" == "null" || -z "$value" ]]; then
        echo ""
        return 0
    fi

    echo "$value"
    return 0
}


set_variable(){
    local variable="$1"
    local value="$2"
    local file="{{cookiecutter.DOTFILES_METADATA}}"
    
    if [[ -z "$variable" ]]; then
        $print_debug_script "No variable passed." -t "error"
        return 1
    fi
    if [[ ! -f "$file" ]]; then
        $print_debug_script "No valid metadata file found at $file" -t "error"
        return 1
    fi

    # Determine if value is an array or needs quotes for TOML format
    if [[ "$value" =~ ^\[.*\]$ ]]; then
        # If value looks like an array, keep it as-is
        tomlq ".${variable} = ${value}" "$file" --toml-output > /tmp/temp_file && mv /tmp/temp_file "$file"
    else
        # Assume it's a string and wrap in quotes if necessary
        tomlq ".${variable} = \"${value}\"" "$file" --toml-output > /tmp/temp_file && mv /tmp/temp_file "$file"
    fi
    
    local status=$?
    if [[ $status -ne 0 ]]; then
        $print_debug_script "Error $status setting variable $variable to $value in $file" -t "error"
        return 1
    fi
    return 0
}
