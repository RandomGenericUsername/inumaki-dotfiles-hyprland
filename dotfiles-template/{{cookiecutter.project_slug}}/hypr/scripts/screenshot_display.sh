#!/bin/bash
# .config/hypr/scripts/screenshot_display.sh
# Screenshot the current display Shift+Print

notify-send "Screenshot" "Select the area to screenshot"
output_id=$(hyprctl -t get_outputs | jq -r '.[] | select(.focused).name')
grim -o $output_id - | swappy -f -
