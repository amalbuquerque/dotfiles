#!/bin/sh
xrandr --output DVI-I-1-1 --off --output DP-1 --off --output eDP-1 --off --output DP-2 --primary --mode 3440x1440 --pos 0x0 --rotate normal

xset r rate 300 50
/home/andre/lxlayout.sh
