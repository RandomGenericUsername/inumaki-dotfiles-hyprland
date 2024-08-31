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


create_symbolic_link() {
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
