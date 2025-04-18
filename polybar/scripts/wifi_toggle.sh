#!/usr/bin/env bash
STATE="$HOME/.cache/polybar/wifi_detail"
[[ -f $STATE ]] || echo off >"$STATE"
[[ $(<"$STATE") == off ]] && echo on >"$STATE" || echo off >"$STATE"
