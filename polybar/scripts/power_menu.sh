#!/bin/bash

# Set your Rofi theme path
ROFI_THEME="$HOME/.config/rofi/config.rasi"

# Function to confirm actions like poweroff, reboot, logout
confirm_exit() {
    echo -e "y\nn" | rofi -dmenu -p "$1? (y/n)" -theme "$ROFI_THEME"
}

# Present menu using Rofi
chosen=$(echo -e "󰌾 Lock\n󰂠 Suspend\n󰐥 Poweroff\n󰜉 Reboot\n󰍃 Logout" | \
    rofi -dmenu -i -p "Power Menu" -theme "$ROFI_THEME")

# Handle selection
case "$chosen" in
    "󰌾 Lock")
        betterlockscreen -l
        ;;
    "󰂠 Suspend")
        systemctl suspend
        ;;
    "󰐥 Poweroff")
        [[ $(confirm_exit "Power off") == "y" ]] && systemctl poweroff
        ;;
    "󰜉 Reboot")
        [[ $(confirm_exit "Reboot") == "y" ]] && systemctl reboot
        ;;
    "󰍃 Logout")
        [[ $(confirm_exit "Logout") == "y" ]] && i3-msg exit
        ;;
    *)
        exit 1
        ;;
esac
