#!/bin/bash
WIN_ID=$(hyprctl clients | grep -B 5 "class: qalculate-gtk" | grep "windowID" | awk '{print $2}')
if [ -n "$WIN_ID" ]; then
    hyprctl dispatch togglefloating $WIN_ID
else
    qalculate-gtk &
fi
