create_python_venv() {
    local venv_dir="$1"

    # Check if the virtual environment directory is provided
    if [ -z "$venv_dir" ]; then
        print_debug "Usage: create_python_venv <path_to_venv_directory>" -t "error"
        exit 1
    fi

    # Create the virtual environment
    python3 -m venv "$venv_dir"
    if [ $? -ne 0 ]; then
        print_debug "Error: Could not create virtual environment at $venv_dir" -t "error"
        exit 1
    fi

    print_debug "Virtual environment created at $venv_dir"
    return 0
}


install_packages_in_venv() {
    local requirements_path="$1"
    local venv_dir="$2"

    # Check if both arguments are provided
    if [ -z "$requirements_path" ] || [ -z "$venv_dir" ]; then
        print_debug "Usage: install_packages_in_venv <path_to_requirements.txt> <path_to_venv_directory>" -t "error"
        exit 1
    fi

    # Check if the requirements file exists
    if [ ! -f "$requirements_path" ]; then
        print_debug "Error: Requirements file not found at $requirements_path" -t "error"
        exit 1
    fi

    # Activate the virtual environment
    source "$venv_dir/bin/activate"
    if [ $? -ne 0 ]; then
        print_debug "Error: Could not activate virtual environment at $venv_dir" -t "error"
        exit 1
    fi

    python -m ensurepip --upgrade
    # Install the required packages
    pip install --upgrade pip
    pip install -r "$requirements_path"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install packages from $requirements_path"
        deactivate
        exit 1
    fi

    # Deactivate the virtual environment
    deactivate

    print_debug "Packages installed successfully in virtual environment at $venv_dir"
}
