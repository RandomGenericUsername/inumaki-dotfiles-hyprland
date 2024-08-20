# Capture the output from the venv get command
#eval "arr=($(venv get favorite_colors --config /home/inumaki/temp/config.sh))"
#
## Access the array elements
#echo "First color: ${arr[0]}"
#echo "Second color: ${arr[1]}"
#echo "Third color: ${arr[2]}"
#echo "Fourth color: ${arr[3]}"

#!/bin/bash

# Capture the output from the venv get command
#output=$(venv get mode_descriptions --config /home/inumaki/temp/config.sh)
#
## Check the output
#echo "Output is: $output"
#
## Initialize an associative array
#declare -A descriptions
#
## Process the output to create the associative array
#while IFS=':' read -r key value; do
#    descriptions[$key]=$value
#done <<< "$output"
#
## Access the elements of the associative array
#echo "Battery Saver Mode Description: ${descriptions["Battery saver"]}"
#echo "High Performance Mode Description: ${descriptions["High performance"]}"
