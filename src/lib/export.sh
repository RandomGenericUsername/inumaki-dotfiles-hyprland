#!/bin/bash


# Define scripts to ignore
ignore=("export.sh")

# Get the directory where this script is located
export LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Iterate through all .sh files in the directory
for script in "$LIB_DIR"/*.sh; do
    script_name=$(basename "$script")

    # Skip the script if it's in the ignore list
    if [[ " ${ignore[*]} " == *" $script_name "* ]]; then
        continue
    fi

    # Export the script path variable
    var_name=$(echo "$script_name" | awk '{print toupper($0)}' | sed 's/[^A-Z0-9]/_/g' | sed 's/_SH$//')
    export "${var_name}_SCRIPT=$script"

    # Source the script
    source "$script"
done


