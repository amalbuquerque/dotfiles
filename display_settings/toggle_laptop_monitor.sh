#!/bin/bash
# turned off if there's no resolution on the screen first line on the xrandr list
if xrandr | grep -q "eDP-1 connected "; then
    xrandr --output eDP-1 --auto
else
    xrandr --output eDP-1 --off
fi
