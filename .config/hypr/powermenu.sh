#!/bin/sh

selected=$(printf "  Shutdown\n  Restart\n  Suspend\n  Logout" | wofi --dmenu -p "Power Menu")

case "$selected" in
    "  Shutdown")
        systemctl poweroff
        ;;
    "  Restart")
        systemctl reboot
        ;;
    "  Suspend")
        systemctl suspend
        ;;
    "  Logout")
        hyprctl dispatch exit
        ;;
esac

