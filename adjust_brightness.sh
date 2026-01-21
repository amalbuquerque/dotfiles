#!/bin/bash

# Get current brightness value
current=$(ddcutil getvcp 10 | grep -oP 'current value =\s+\K\d+')

# Toggle between 50 and 85
if [ "$current" -eq 50 ]; then
    new_value=85
else
    new_value=50
fi

# Set new brightness value
ddcutil setvcp 10 "$new_value"

echo "Brightness changed from $current to $new_value"
