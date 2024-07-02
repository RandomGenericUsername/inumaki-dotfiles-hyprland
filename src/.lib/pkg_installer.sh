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
        print "Package $package is already installed." -t "debug" -l "$LOG"
    else
        result=1
        print "Package $package is not installed." -t "debug" -l "$LOG"
    fi
    
    return $result
}


_isInstalledYay() {
    package="$1"
    
    # Check if the package is installed
    check=$(yay -Q "$package" 2>/dev/null)
    
    if [ -n "$check" ]; then
        result=0
        print "Package $package is already installed." -t "debug" -l "$LOG"
    else
        result=1
        print "Package $package is not installed." -t "debug" -l "$LOG"
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
        print "All packages are installed" -t "debug" -l "$LOG"
        return 0
    fi;

    # Join the array elements into a single string
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    print "Installing ${joined_toInstall}" -t "debug" -l "$LOG"
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

_forcePackagesPacman() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        print "All packages are installed" -t "debug" -l "$LOG"
        return 0;
    fi;

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    print "Installing ${joined_toInstall}" -t "debug" -l "$LOG"
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
        print "All packages are installed" -t "debug" -l "$LOG"
        return 0;
    fi;
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    print "Installing ${joined_toInstall}" -t "debug" -l "$LOG"
    yay --noconfirm -S "${toInstall[@]}";
}

_forcePackagesYay() {
    toInstall=();
    for pkg; do
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        print "All packages are installed" -t "debug" -l "$LOG"
        return 0;
    fi;
    local joined_toInstall=$(printf "%s, " "${toInstall[@]}")
    joined_toInstall=${joined_toInstall%, }  # Remove the trailing comma and space
    print "Installing ${joined_toInstall}" -t "debug" -l "$LOG"
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


# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------

prompt_for_removal() {
    local file_or_dir="$1"
    local gum_options=("Delete" "Keep")
    local msg="The file or directory '$file_or_dir' is not empty. How would you like to proceed?"
    choice=$(gum choose "${gum_options[@]}" --header="$msg")
    case "$choice" in
        "Delete")
            print "deleting $file_or_dir" -t "warn" -l "$LOG"
            rm -rf "$file_or_dir"
            ;;
        "Keep")
            print "Keeping the existing file or directory: $file_or_dir" -t "error" -l "$LOG"
            print "Exiting now..." -t "error" -l "$LOG"
            exit 1
            ;;
    esac
    return 0
}

create_ln() {
    local symlink_name=""
    local sources=()
    local targets=()
    local parsing_sources=false
    local parsing_targets=false


    # Check if at least three arguments are provided
    if [ "$#" -lt 3 ]; then
        print "Usage: create_ln <symlink-name> --source <source-1> <source-2> ... --target <target-1> <target-2> ..." -t "error" 
        return 1
    fi

    # Extract the symlink name
    symlink_name="$1"
    shift

    # Parse the rest of the arguments
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --source|-s)
                parsing_sources=true
                parsing_targets=false
                shift
                ;;
            --target|-t)
                parsing_sources=false
                parsing_targets=true
                shift
                ;;
            *)
                if [ "$parsing_sources" = true ]; then
                    sources+=("$1")
                elif [ "$parsing_targets" = true ]; then
                    targets+=("$1")
                else
                    echo "Unexpected argument: $1"
                    return 1
                fi
                shift
                ;;
        esac
    done

    # Check if sources and targets arrays are not empty
    if [ "${#sources[@]}" -eq 0 ] || [ "${#targets[@]}" -eq 0 ]; then
        print "Both --source and --target options must have at least one argument each." -t "error"
        return 1
    fi

    # Check the symlink_name type (directory, symlink, etc.)
    if [ -L "$symlink_name" ]; then
        print "Removing existing symbolic link: $symlink_name" -t "warn" -l "$LOG"
        rm "$symlink_name"
    elif [ -d "$symlink_name" ]; then
        if [ -z "$(ls -A "$symlink_name")" ]; then
            print "Removing empty directory: $symlink_name" -t "warn" -l "$LOG"
            rmdir "$symlink_name"
        else
            prompt_for_removal "$symlink_name"
        fi
    elif [ -f "$symlink_name" ]; then
        if [ ! -s "$symlink_name" ]; then
            print "Removing empty file: $symlink_name" -t "warn" -l "$LOG"
            rm "$symlink_name"
        else
            prompt_for_removal "$symlink_name"
        fi
    fi

    # Create symbolic links based on the provided scenarios
    if [[ "$symlink_name" == */ ]]; then
        for source in "${sources[@]}"; do
            for target in "${targets[@]}"; do
                local base_source=$(basename "$source")
                local link_path="$target/$base_source"
                link_path=$(echo "$link_path" | sed 's|//*|/|g') # Remove repeated slashes
                print "Creating symlink: $source -> $link_path" -t "debug" -l "$LOG"
                ln -s "$source" "$link_path"
            done
        done
    else
        for source in "${sources[@]}"; do
            for target in "${targets[@]}"; do
                local link_path="$target/$(basename "$symlink_name")"
                link_path=$(echo "$link_path" | sed 's|//*|/|g') # Remove repeated slashes
                print "Creating symlink: $source -> $link_path" -t "debug" -l "$LOG"
                ln -s "$source" "$link_path"
            done
        done
    fi
}
