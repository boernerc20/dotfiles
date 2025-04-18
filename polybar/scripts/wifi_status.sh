#!/usr/bin/env bash
#
#  - prints a line to STDOUT every time something worth redrawing happens
#  - listens for:   state‑file change  OR  link up/down (netlink) OR  5s timer

iface="YOUR_INTERFACE"
STATE="$HOME/.cache/polybar/wifi_detail"   # "on" or "off"
mkdir -p "$(dirname "$STATE")"; : >"$STATE" || echo off >"$STATE"

print() {
  detail=$(<"$STATE")
  ssid=$(iwgetid -r)

  if [[ -z $ssid ]]; then
    echo "󰖪  down"
    return
  fi

  if [[ $detail == on ]]; then
    rx=$(cat /sys/class/net/$iface/statistics/rx_bytes)
    tx=$(cat /sys/class/net/$iface/statistics/tx_bytes)
    ip=$(hostname -I | awk '{print $1}')
    printf "  %s |  %s kB  %s kB | %s\n" \
           "$ssid" "$((rx/1024))" "$((tx/1024))" "$ip"
  else
    echo "  $ssid"
  fi
}

###############################################################################
#  Main loop: initial draw, then wait for events
###############################################################################
print

# background timer for bandwidth refresh
while true; do
  # 1) wait up to 5 s for either:
  #    - state‑file modified
  #    - netlink link event
  # 2) if timeout, we still redraw to update rx/tx counters
  {
    # inotifywait exits after one event or 5 s timeout
    inotifywait -q -e modify "$STATE" -t 5 2>/dev/null
  } || true

  print
done
