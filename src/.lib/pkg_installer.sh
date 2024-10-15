: '
     __ __           __              _            __        ____               __ __
  __/ // /_   ____  / /______ _     (_)___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/  / __ \/ //_/ __ `/    / / __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  / /_/ / ,< / /_/ /    / / / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    / .___/_/|_|\__, /____/_/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/
          /_/         /____/_____/
'
#!/bin/bash


_parsePackagesFromFile() {
    file="$1"
    packages=""

    while IFS= read -r line; do
        # Skip empty lines and comments
        if [[ -n "$line" && "${line:0:1}" != "#" ]]; then
            if [[ -z "$packages" ]]; then
                packages="$line"
            else
                packages="$packages $line"
            fi
        fi
    done < "$file"

    echo "$packages"
}

_isInstalledPacman() {
    package="$1"
    
    # Check if the package is installed
    check=$(pacman -Q "$package" 2>/dev/null)
    
    if [ -n "$check" ]; then
        result=0
        $print_debug "Package '$package' is already installed." -t "debug" 
    else
        result=1
        $print_debug "Package '$package' is not installed." -t "debug" 
    fi
    
    return $result
}


_isInstalledYay() {
    package="$1"
    
    # Check if the package is installed
    check=$(yay -Q "$package" 2>/dev/null)
    
    if [ -n "$check" ]; then
        result=0
        $print_debug "Package $package is already installed." -t "debug" 
    else
        result=1
        $print_debug "Package $package is not installed." -t "debug" 
    fi
    
    return $result
}


# ------------------------------------------------------
# Function Install all package if not installed
# ------------------------------------------------------
_installPackagesPacman() {
    toInstall=();
    for pkg; do
        if  _isInstalledPacman "${pkg}"; then
            continue
        fi
        toInstall+=("${pkg}")
    done

    if [[ "${toInstall[@]}" == "" ]] ; then
        $print_debug "All packages are installed" -t "debug" 
        return 0
    fi;

    # Join the array elements into a single string
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    $print_debug "Installing ${joined_toInstall}" -t "debug" 
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

_forcePackagesPacman() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        $print_debug "All packages are installed" -t "debug" 
        return 0;
    fi;

    # printf_debug "Package not installed:\n%s\n" "${toInst
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    $print_debug "Installing ${joined_toInstall}" -t "debug" 
    sudo pacman --noconfirm -S "${toInstall[@]}" --ask 4;
}

_installPackagesYay() {
    toInstall=();
    for pkg; do
        if _isInstalledYay "${pkg}"; then
            continue
        fi
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        $print_debug "All packages are installed" -t "debug" 
        return 0;
    fi;
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    $print_debug "Installing ${joined_toInstall}" -t "debug" 
    yay --noconfirm -S "${toInstall[@]}";
}

_forcePackagesYay() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        $print_debug "All packages are installed" -t "debug" 
        return 0;
    fi;
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    $print_debug "Installing ${joined_toInstall}" -t "debug" 
    yay --noconfirm -S "${toInstall[@]}" --ask 4;
}

install_pacman_packages(){
    local packagesFilePath="$1"
    local packages="$(_parsePackagesFromFile $packagesFilePath)"
    if [[ "$2" == "-f" || "$2" == "--force" || "$INSTALL_TYPE" == "clean" ]]; then
        _forcePackagesPacman $packages
    else
        _installPackagesPacman $packages
    fi
}

install_yay_packages(){
    local packagesFilePath="$1"
    local packages="$(_parsePackagesFromFile $packagesFilePath)"
    if [[ "$2" == "-f" || "$2" == "--force" || "$INSTALL_TYPE" == "clean" ]]; then
        _forcePackagesYay $packages
    else
        _installPackagesYay $packages
    fi
}

