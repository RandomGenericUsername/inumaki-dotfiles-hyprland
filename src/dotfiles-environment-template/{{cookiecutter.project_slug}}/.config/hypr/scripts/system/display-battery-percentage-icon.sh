#!/bin/bash

# Find battery device
BATTERY_PATH=$(grep -l "Battery" /sys/class/power_supply/*/type | sed 's|/type||' | head -n 1)

# Fallback if no battery
if [ -z "$BATTERY_PATH" ]; then
  echo '{"text": "⚠", "class": "no-battery", "tooltip": "No battery found"}'
  exit 1
fi

# Read capacity and status at once
read -r CHARGE < "$BATTERY_PATH/capacity"
read -r STATUS < "$BATTERY_PATH/status"

# Choose class based on charge
if [ "$CHARGE" -ge 95 ]; then
  CLASS="battery-100"
elif [ "$CHARGE" -ge 65 ]; then
  CLASS="battery-75"
elif [ "$CHARGE" -ge 35 ]; then
  CLASS="battery-50"
elif [ "$CHARGE" -ge 15 ]; then
  CLASS="battery-25"
else
  CLASS="battery-0"
fi


# Append -charging if charging
if [[ "$STATUS" == "Charging" ]]; then
  CLASS="${CLASS}-charging"
fi

# Output JSON
echo "{\"text\": \".\", \"class\": \"$CLASS\"}"
