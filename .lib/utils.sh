: '
     __ __     __  ____  _ __          __ __
  __/ // /_   / / / / /_(_) /____   __/ // /_
 /_  _  __/  / / / / __/ / / ___/  /_  _  __/
/_  _  __/  / /_/ / /_/ / (__  )  /_  _  __/
 /_//_/     \____/\__/_/_/____/    /_//_/

'
#!/bin/bash

# Script dir
script_dir=$(dirname $BASH_SOURCE)

# Access debug function
debug_functions=$script_dir/debug_functions.sh
source $debug_functions #debug_print

create_dir_for_file() {
    local file="$1"
    local file_dir=$(dirname "$file")
    if [ ! -d "$file_dir" ]; then
        mkdir -p "$file_dir" || {
            debug_print "Failed to create log directory: $file_dir"
            return 1
        }
    fi
    return 0
}

clean_log() {
    local log=$1
    debug_print "Cleaning log file: $path"
    echo '' > $log
}
