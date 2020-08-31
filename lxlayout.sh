#!/bin/bash
# crazy xkbcomp bug: https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/issues/9
# the `xdotool key Ctrl` is to force the mapping to be applied, otherwise it only
# worked with another keyboard plugged in (as in, it didn't work just with the laptop keyboard)
xkbcomp -w0 -I$HOME/projs/personal/xkb_spike -a /home/andre/projs/personal/xkb_spike/neo_map $DISPLAY && xdotool key Ctrl
numlockx off
