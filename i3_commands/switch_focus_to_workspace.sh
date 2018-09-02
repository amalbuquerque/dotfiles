#!/bin/sh
SWITCH_TO=$(i3-input -f xft:Ubuntu Bold 15 -P 'Focus workspace: ' | grep output | awk '{ print $3 }')
WORKSPACE_FOUND=$(i3-msg -t get_workspaces | jq '.[] | .name' | grep $SWITCH_TO)
i3-msg workspace $WORKSPACE_FOUND

exit 0
