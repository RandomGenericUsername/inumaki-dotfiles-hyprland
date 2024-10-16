create_python_venv() {
    local python_executable="$1"
    local venv_dir="$2"

    # Check if the virtual environment directory is provided
    if [ -z "$venv_dir" ]; then
        $print_debug "Usage: create_python_venv <path_to_python_executable> <path_to_venv_directory>" -t "error"
        exit 1
    fi

    if [ ! -x "$python_executable" ]; then
        $print_debug "Error: Python executable not found at '$python_executable'. Ensure the Python version is installed." -t "error"
        exit 1
    fi

    $print_debug "Creating virtual environment at '$venv_dir' using Python executable at '$python_executable'..."
    "$python_executable" -m venv "$venv_dir"
    if [ $? -ne 0 ]; then
        $print_debug "Error: Could not create virtual environment at '$venv_dir' using '$python_executable'" -t "error"
        exit 1
    fi

    $print_debug "Virtual environment created at '$venv_dir' using Python executable at '$python_executable'"
    return 0
}



install_packages_in_venv() {
    local requirements_path="$1"
    local venv_dir="$2"

    # Check if both arguments are provided
    if [ -z "$requirements_path" ] || [ -z "$venv_dir" ]; then
        $print_debug "Usage: install_packages_in_venv <path_to_requirements.txt> <path_to_venv_directory>" -t "error"
        exit 1
    fi

    # Check if the requirements file exists
    if [ ! -f "$requirements_path" ]; then
        $print_debug "Error: Requirements file not found at '$requirements_path'" -t "error"
        exit 1
    fi

    # Activate the virtual environment
    source "$venv_dir/bin/activate"
    if [ $? -ne 0 ]; then
        $print_debug "Error: Could not activate virtual environment at '$venv_dir'" -t "error"
        exit 1
    fi

    run "python -m ensurepip --upgrade"
    run "pip install --upgrade pip"
    run "pip install -r $requirements_path"

    # Deactivate the virtual environment
    deactivate

    $print_debug "Packages installed successfully in virtual environment at '$venv_dir'"
}

