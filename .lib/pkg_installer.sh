: '
     __ __           __              _            __        ____               __ __
  __/ // /_   ____  / /______ _     (_)___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/  / __ \/ //_/ __ `/    / / __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  / /_/ / ,< / /_/ /    / / / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    / .___/_/|_|\__, /____/_/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/
          /_/         /____/_____/
'
#!/bin/bash

# Script dir
script_dir=$(dirname $BASH_SOURCE)

# Access debug function
debug_functions=$script_dir/debug.sh
source $debug_functions #debug_print


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
    package="$1";
    check="$(sudo pacman -Qs --color always $package | grep 'local' | grep $package)"
    if [ -n "${check}" ] ; then
        result=0
        print "Package $package is already installed." debug
    else
        result=1
        print "Package $package is not installed." debug
    fi
    return $result
}


_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always $package | grep 'local' | grep '\.' | grep $package)"
    if [ -n "${check}" ] ; then
        result=0
        print "Package $package is already installed." debug
    else
        result=1
        print "Package $package is not installed." debug
    fi
    return $result
}

_isFolderEmpty() {
    folder="$1"
    if [ -d $folder ] ;then
        if [ -z "$(ls -A $folder)" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
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
        print "All packages are installed" "debug"
        return 0
    fi;
    print "Installing ${toInstall[@]}"
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

_forcePackagesPacman() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        return 0;
    fi;

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
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
        print "All packages are installed" "debug"
        return 0;
    fi;
    print "Installing ${toInstall[@]}" "debug"
    yay --noconfirm -S "${toInstall[@]}";
}

_forcePackagesYay() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        return 0;
    fi;
    yay --noconfirm -S "${toInstall[@]}" --ask 4;
}

install_pacman_packages(){
    local packagesFilePath="$1"
    local packages="$(_parsePackagesFromFile $packagesFilePath)"
    print "path: $packagesFilePath" "debug"
    print "packages: $packages" "debug"
    #_forcePackagesPacman $packages
    _installPackagesPacman $packages
}

install_yay_packages(){
    local packagesFilePath="$1"
    local packages="$(_parsePackagesFromFile $packagesFilePath)"
    #_forcePackagesYay $packages
    _installPackagesYay $packages
}


# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
_installSymLink() {
    name="$1"
    symlink="$2";
    linksource="$3";
    linktarget="$4";

    if [ -L "${symlink}" ]; then
        rm ${symlink}
        ln -s ${linksource} ${linktarget}
        print "Symlink ${linksource} -> ${linktarget} created."
    else
        if [ -d ${symlink} ]; then
            rm -rf ${symlink}/
            ln -s ${linksource} ${linktarget}
            print "Symlink for directory ${linksource} -> ${linktarget} created."
        else
            if [ -f ${symlink} ]; then
                rm ${symlink}
                ln -s ${linksource} ${linktarget}
                print "Symlink to file ${linksource} -> ${linktarget} created."
            else
                ln -s ${linksource} ${linktarget}
                print "New symlink ${linksource} -> ${linktarget} created."
            fi
        fi
    fi
}




# ------------------------------------------------------
# System check
# ------------------------------------------------------
_commandExists() {
    package="$1";
    if ! type $package > /dev/null 2>&1; then
        echo ":: ERROR: $package doesn't exists. Please install it with yay -S $2"
    else
        echo ":: OK: $package command found."
    fi
}

_folderExists() {
    folder="$1";
    if [ ! -d $folder ]; then
        echo ":: ERROR: $folder doesn't exists. $2"
    else
        echo ":: OK: $folder found."
    fi
}


