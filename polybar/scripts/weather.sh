#!/usr/bin/env bash
#
# Weather with local °F ⇆ °C conversion
#   ./weather.sh          → prints temp in last‑chosen unit
#   ./weather.sh toggle   → flips unit flag

API_KEY="YOUR_API"
CITY="YOUR_CITY"
STATE="$HOME/.cache/polybar/weather_unit"   # F or C
mkdir -p "$(dirname "$STATE")"
[[ -f "$STATE" ]] || echo F >"$STATE"

###############################################################################
# flip the unit?
###############################################################################
if [[ $1 == toggle ]]; then
  [[ $(<"$STATE") == F ]] && echo C >"$STATE" || echo F >"$STATE"
  exit 0
fi

UNIT=$(<"$STATE")      # F or C

###############################################################################
# fetch once in °F
###############################################################################
weather=$(curl -sf \
  "https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=imperial") \
  || { echo " Weather"; exit 1; }

temp_f=$(jq '.main.temp' <<<"$weather")
desc=$(jq -r '.weather[0].main' <<<"$weather")

###############################################################################
# convert if needed
###############################################################################
if [[ $UNIT == C ]]; then
  temp=$(awk "BEGIN{printf \"%.0f\", ($temp_f-32)*5/9}")
  symbol="°C"
else
  temp=$(awk "BEGIN{printf \"%.0f\", $temp_f}")
  symbol="°F"
fi

###############################################################################
# icon
###############################################################################
case $desc in
  Clear)                icon="" ;;
  Clouds)               icon="" ;;
  Rain)                 icon="" ;;
  Drizzle)              icon="" ;;
  Thunderstorm)         icon="" ;;
  Snow)                 icon="" ;;
  Mist|Fog|Haze)        icon="" ;;
  *)                    icon="" ;;
esac

echo "$icon ${temp}${symbol}"
