#!/bin/sh
N=$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true).num')
# notify-send "Hello Workspace $N"
i3-input -f xft:Ubuntu Bold 15 -F "rename workspace to \"$N: %s\"" -P 'New name: '
exit 0
