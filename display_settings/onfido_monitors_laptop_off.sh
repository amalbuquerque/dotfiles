#!/bin/sh
xset r rate 300 50
/home/andre/lxlayout.sh
xrandr --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal --output eDP-1 --off --output DP-2 --off
