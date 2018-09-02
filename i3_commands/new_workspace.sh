#!/bin/sh
WORKSPACE_NAME=$(i3-input -f xft:Ubuntu Bold 15 -P 'Workspace name: ' | grep output | awk '{ print $3 }')
MAX_WORKSPACE=$(i3-msg -t get_workspaces | jq '.[] | .num' | tail -1)
NEW_WORKSPACE_NUMBER=$((MAX_WORKSPACE + 1))
i3-msg workspace "$NEW_WORKSPACE_NUMBER: $WORKSPACE_NAME"

exit 0
