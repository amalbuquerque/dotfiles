#!/bin/sh
SWITCH_TO=$1
WORKSPACE_FOUND=$(i3-msg -t get_workspaces | jq ".[] | select( .num == $SWITCH_TO ) | .name")

if [ -z "$WORKSPACE_FOUND" ]
then
    WORKSPACE_FOUND=$SWITCH_TO
fi

i3-msg move container to workspace $WORKSPACE_FOUND

exit 0
