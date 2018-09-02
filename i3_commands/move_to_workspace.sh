#!/bin/sh
SWITCH_TO=$(i3-input -f xft:Ubuntu Bold 15 -P 'Move to workspace: ' | grep output | awk '{ print $3 }')
WORKSPACE_FOUND=$(i3-msg -t get_workspaces | jq '.[] | .name' | grep $SWITCH_TO)
i3-msg move container to workspace $WORKSPACE_FOUND

exit 0
