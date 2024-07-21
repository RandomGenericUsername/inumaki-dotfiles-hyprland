#!/bin/bash

wallpaper_folder=${{WALLPAPER_DIR}}

if [ x"$@" != x"" ]; then
    echo "$@" > /tmp/.tmp.delete
fi
find -L "$wallpaper_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
do
    echo -en "\x00icon\x1f$wallpaper_folder/${rfile}\n"
    #echo -en "$rfile\x00icon\x1f$wallpaper_folder/${rfile}\n"
done


