#!/bin/bash


path={{cookiecutter.WAYBAR_THEMES_DIR}}/default-top-left

# Launch the first Waybar instance in the background
waybar --bar main -c "${path}/main-config"  &

# Launch the second Waybar instance in the background
waybar --bar aux -c "${path}/aux-config"   &


