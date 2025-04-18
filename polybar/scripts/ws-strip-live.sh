#!/usr/bin/env bash
# ws-strip-live.sh — print icons, redraw only on workspace events

ACTIVE_FG='#D1C4E9'
INACTIVE_FG='#777777'
UNDERLINE='#D1C4E9'
SEP="  "

print_icons() {
  i3-msg -t get_workspaces \
    | jq -r 'sort_by(.num)[] | "\(.name)\t\(.focused)"' \
    | while IFS=$'\t' read -r name focused; do
        icon="${name#*:}"
        if [[ "$focused" == "true" ]]; then
          printf '%%{+u}%%{u%s}%%{F%s}%s%%{-u}%%{F-}%s' \
                 "$UNDERLINE" "$ACTIVE_FG" "$icon" "$SEP"
        else
          printf '%%{F%s}%s%%{F-}%s' "$INACTIVE_FG" "$icon" "$SEP"
        fi
      done
  echo
}

# Initial draw
print_icons

# Subscribe to workspace events and redraw on each
i3-msg -m -t subscribe '[ "workspace" ]' | while read -r _; do
  print_icons
done
