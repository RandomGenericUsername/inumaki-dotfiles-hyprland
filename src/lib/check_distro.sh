check_distro() {
    local file_path="$1"

    # Check if the file exists
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File not found."
        exit 1
    fi

    # Get the current distribution
    current_distro=$(grep '^ID_LIKE=' /etc/os-release | cut -d'=' -f2 | tr -d '"')

    # Check if the current distribution is in the file
    if grep -q "^$current_distro$" "$file_path"; then
        #echo "Distribution '$current_distro' is supported."
        return 0
    else
        echo "Error: Distribution '$current_distro' is not supported."
        exit 2
    fi
}
