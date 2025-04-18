#!/bin/bash

# set_wallpaper.sh [1-5]
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_wallpaper"

case $1 in
  1) WALL="$WALLPAPER_DIR/jig_jig2.png" ;;
  2) WALL="$WALLPAPER_DIR/cyber_car.png" ;;
  3) WALL="$WALLPAPER_DIR/mclaren.png" ;;
  4) WALL="$WALLPAPER_DIR/ferris_wheel.png" ;;
  5) WALL="$WALLPAPER_DIR/wallpaper1.png" ;;
  0) WALL="$WALLPAPER_DIR/blade_runner.png" ;;  # default
  *) echo "Invalid wallpaper ID"; exit 1 ;;
esac

# Set wallpaper and save to cache
feh --bg-fill "$WALL"
echo "$WALL" > "$CACHE_FILE"
