#!/usr/bin/env bash
# Prints   when Playing,   otherwise.  Updates instantly.

print_icon() {
  if playerctl status 2>/dev/null | grep -q 'Playing'; then
    echo "  "
  else
    echo "  "
  fi
}

print_icon            # initial draw

# Follow playerctl events and redraw on every state change
playerctl --follow status | while read -r _; do
  print_icon
done
