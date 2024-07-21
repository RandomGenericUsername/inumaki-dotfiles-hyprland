#!/bin/bash
path=${{HYPR_WALLPAPER_EFFECTS_DIR}}
find -L "$path" -type f | sort -R | while read -r rfile
do
	echo -en "$(basename "$rfile")\x00icon\x1f$path/$(basename "$rfile")\n"
done