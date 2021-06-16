#!/bin/sh
xset r rate 300 50
/home/andre/lxlayout.sh
xrandr --output DP-1 --off --output eDP-1 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --mode 1920x1080 --pos 1920x0 --output DP-4 --off
