#!/bin/bash

# Find battery device
BATTERY_PATH=$(grep -l "Battery" /sys/class/power_supply/*/type | sed 's|/type||' | head -n 1)
# Get power profile
PROFILE=$(powerprofilesctl get)
#
BATTERY_DETAIL_PATH=$(upower -e | grep BAT)
BATTERY_INFO=$(upower -i "$BATTERY_DETAIL_PATH")
STATE=$(echo "$BATTERY_INFO" | awk -F: '/state/ {gsub(/ /, "", $2); print $2}')
TIME_TO_EMPTY=$(upower -i "$(upower -e | grep BAT)" | awk -F':' '/time to empty/ {print $2":"$3}' | xargs)


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

case "$STATE" in
  discharging)
    TIME=$(echo "$BATTERY_INFO" | awk -F: '/time to empty/ {print $2":"$3}' | xargs)
    TOOLTIP="Power profile: $PROFILE\\nTime left: $TIME"
    ;;
  charging)
    TIME=$(echo "$BATTERY_INFO" | awk -F: '/time to full/ {print $2":"$3}' | xargs)
    TOOLTIP="Power profile: $PROFILE\\nTime to full: $TIME"
    ;;
  *)
    TOOLTIP="Power profile: $PROFILE"
    ;;
esac
echo "{\"text\": \".\", \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"


# Output JSON
#echo "{\"text\": \".\", \"class\": \"$CLASS\"}"
# Output JSON with tooltip
#echo "{\"text\": \".\", \"class\": \"$CLASS\", \"tooltip\": \"Power profile: $PROFILE\\nClick to toggle.\"}"
# Get time to empty
# Output JSON with tooltip
#echo "{\"text\": \".\", \"class\": \"$CLASS\", \"tooltip\": \"Power profile: $PROFILE\\nTime left: $TIME_TO_EMPTY.\"}"
