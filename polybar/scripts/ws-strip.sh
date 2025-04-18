#!/usr/bin/env bash
# Print i3 workspace icons, highlight the focused one

ACTIVE_FG='#D1C4E9'    # same purple you use elsewhere
INACTIVE_FG='#777777'  # pick any dim color here
UNDERLINE='#D1C4E9'    # underline color
SEP="  "               # spacing between icons

i3-msg -t get_workspaces \
  | jq -r 'sort_by(.num)[] | "\(.name)\t\(.focused)"' \
  | while IFS=$'\t' read -r name focused; do
      icon="${name#*:}"          # strip leading “n:”

      if [[ "$focused" == "true" ]]; then
        # underline + bright color
        printf '%%{+u}%%{u%s}%%{F%s}%s%%{-u}%%{F-}%s' \
               "$UNDERLINE" "$ACTIVE_FG" "$icon" "$SEP"
      else
        # dim inactive icon
        printf '%%{F%s}%s%%{F-}%s' \
               "$INACTIVE_FG" "$icon" "$SEP"
      fi
    done
echo
