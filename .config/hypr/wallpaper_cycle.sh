#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Delay in seconds between wallpaper changes
DELAY=1800

# Hyprpaper configuration file
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Output/display (update this based on your display name, e.g., eDP-1, HDMI-A-1)
OUTPUT="eDP-1"

# Function to update Hyprpaper with a new wallpaper
update_wallpaper() {
    local wallpaper="$1"
    # Write the new wallpaper setting to Hyprpaper's config file
    echo "preload = $wallpaper" > "$HYPRPAPER_CONF"
    echo "wallpaper = $OUTPUT,$wallpaper" >> "$HYPRPAPER_CONF"
    # Restart Hyprpaper to apply the new wallpaper
    pkill hyprpaper
    hyprpaper &
}

# Infinite loop to cycle through wallpapers
while true; do
    for wallpaper in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [ -f "$wallpaper" ] || continue
        update_wallpaper "$wallpaper"
        sleep "$DELAY"
    done
done

