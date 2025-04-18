#!/bin/bash

# Define config file path
CONFIG_FILE="$HOME/.config/picom/picom.conf"

# Read the current inactive opacity value
opacity=$(grep -Po '(?<=inactive-opacity = )\d+(\.\d+)?' "$CONFIG_FILE")

# Toggle between 0.7 and 1.0
if [[ "$opacity" == "0.7" ]]; then
    new_opacity="1.0"
else
    new_opacity="0.7"
fi

# Replace the value in the config file
sed -i "s/inactive-opacity = $opacity;/inactive-opacity = $new_opacity;/" "$CONFIG_FILE"

# Kill Picom properly
pkill -TERM picom
sleep 0.5  # Small delay to ensure Picom fully stops

# Restart Picom with config reloading
picom --config "$CONFIG_FILE" -b
