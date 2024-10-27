check_distro(){
    local file_path="$1"

    # Check if the file exists
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File not found at '$file_path'"
        exit 1
    fi

    # Get ID and ID_LIKE from /etc/os-release
    local distro_id
    local distro_like
    distro_id=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
    distro_like=$(grep '^ID_LIKE=' /etc/os-release | cut -d'=' -f2 | tr -d '"')

    # Determine base distro and check against supported list
    if grep -q "^$distro_like$" "$file_path"; then
        echo "$distro_like"
    elif grep -q "^$distro_id$" "$file_path"; then
        echo "$distro_id"
    else
        echo ""
    fi
}
