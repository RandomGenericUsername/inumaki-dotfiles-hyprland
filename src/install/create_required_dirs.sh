#!/bin/bash

create_dirs() {
    for dir in "$@"; do
        if [ ! -d "$dir" ]; then
            print "Creating directory: $dir" -t "debug" -l "$LOG"
            mkdir -p "$dir"
            else 
                print "Directory already exists: $dir" -t "debug" -l "$LOG"
        fi
    done
}