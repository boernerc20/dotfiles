#!/bin/bash

# List of all icon-only workspace names
workspaces=("" "󰎞" "" "󰍹" "" "")

for ws in "${workspaces[@]}"; do
  i3-msg "workspace \"$ws\"; exec --no-startup-id xdotool key Super_L+Return"
  sleep 0.3
done

# Give windows a second to open
sleep 1.5

# Close all dummy terminals
xdotool search --class Alacritty windowkill

# Return to default workspace
i3-msg 'workspace ""'
