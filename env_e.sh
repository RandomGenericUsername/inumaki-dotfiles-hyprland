#!/bin/bash

ENV_FILE="$HOME/.config/env_vars.conf"
ASSOC_ENV_FILE="$HOME/.config/assoc_vars.conf"


# Ensure the environment file exists
mkdir -p "$(dirname "$ENV_FILE")"
touch "$ENV_FILE"
touch "$ASSOC_ENV_FILE"


set_variable() {
    local var_name="$1"
    shift
    local var_value=("$@")  # Treat var_value as an array to handle all input values

    local return_code=0

    # Check if variable already exists
    if grep -q "^${var_name}=" "$ENV_FILE"; then
        return_code=1  # Existing variable will be overwritten
        sed -i "/^${var_name}=/d" "$ENV_FILE"
    fi

    # Set the variable
    if [[ "${#var_value[@]}" -gt 1 ]]; then
        printf "%s=(" "$var_name" >> "$ENV_FILE"
        for val in "${var_value[@]}"; do
            printf "\"%s\" " "$val" >> "$ENV_FILE"
        done
        printf ")\n" >> "$ENV_FILE"
    else
        echo "$var_name=\"${var_value[0]}\"" >> "$ENV_FILE"
    fi

    # Verify that the variable was set correctly
    source "$ENV_FILE"
    eval "actual_value=\${$var_name[@]}"
    if [[ "$actual_value" != "${var_value[@]}" ]]; then
        return_code=2  # Variable was not set correctly
    fi

    return $return_code
}

get_variable() {
    local var_name="$1"
    source "$ENV_FILE"
    eval "var_value=(\"\${$var_name[@]}\")"  # Treat the retrieved value as an array

    if [[ -z "${!var_name+x}" ]]; then
        echo ""
        return 0  # Variable does not exist
    else
        # Print the array in a format that can be evaluated as an array
        echo "(${var_value[@]})"
        return 1  # Variable exists
    fi
}


# Function to set an associative array
set_associative_array() {
    local var_name="$1"
    shift
    declare -A assoc_array

    local return_code=0

    if grep -q "^${var_name}=" "$ASSOC_ENV_FILE"; then
        return_code=1
        sed -i "/^${var_name}\[/d" "$ASSOC_ENV_FILE"
    fi

    while [[ "$1" && "$2" ]]; do
        key="$1"
        value="$2"
        assoc_array["$key"]="$value"
        shift 2
    done

    for key in "${!assoc_array[@]}"; do
        echo "${var_name}[\"${key}\"]=\"${assoc_array[$key]}\"" >> "$ASSOC_ENV_FILE"
    done

    return $return_code
}




# Function to get an associative array
get_associative_array() {
    local var_name="$1"
    declare -A assoc_array

    while IFS= read -r line; do
        if [[ $line == ${var_name}[*=* ]]; then
            key="${line#${var_name}[\"}"
            key="${key%%\"]*}"
            value="${line#*=}"
            value="${value%\"}"
            value="${value#\"}"
            assoc_array["$key"]="$value"
        fi
    done < "$ASSOC_ENV_FILE"

    if [[ ${#assoc_array[@]} -eq 0 ]]; then
        echo ""
        return 0  # Variable does not exist
    else
        for key in "${!assoc_array[@]}"; do
            echo "\"$key\" -> \"${assoc_array[$key]}\""
        done
        return 1  # Variable exists
    fi
}


delete_variable() {
    local var_name="$1"
    sed -i "/^${var_name}=/d" "$ENV_FILE"
    sed -i "/^${var_name}\[/d" "$ASSOC_ENV_FILE"
    return 0
}

# Function to delete all variables
delete_all_variables() {
    > "$ENV_FILE"  # Clear the main variables file
    > "$ASSOC_ENV_FILE"  # Clear the associative arrays file
    return 0
}


list_variables() {
    cat "$ENV_FILE"
}

# Parse the command
case "$1" in
    set)
        set_variable "$2" "${@:3}"
        return_code=$?
        ;;
    set-assoc)
        set_associative_array "$2" "${@:3}"
        return_code=$?
        ;;
    get)
        get_variable "$2"
        return_code=$?
        ;;
    get-assoc)
        get_associative_array "$2"
        return_code=$?
        ;;
    delete)
        if [[ "$2" == "--all" ]]; then
            delete_all_variables
        else
            delete_variable "$2"
        fi
        ;;
    list)
        list_variables
        ;;
    *)
        echo "Usage: $0 {set|get|set-assoc|get-assoc|delete|list} <variable-name> [values...]"
        ;;
esac

exit $return_code
