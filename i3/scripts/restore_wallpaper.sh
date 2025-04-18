#!/bin/bash

CACHE_FILE="$HOME/.cache/current_wallpaper"

if [ -f "$CACHE_FILE" ]; then
  WALL=$(cat "$CACHE_FILE")
  feh --bg-fill "$WALL"
fi
