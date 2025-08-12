#!/usr/bin/env bash
#
# get_window_icons.sh
#
# Returns a list of icon names for currently open windows under Hyprland

# Get list of window classes from hyprctl
window_classes=$(hyprctl clients -j | jq -r '.[].class' | sort -u)

icons=()

for class in $window_classes; do
    # Search for a .desktop file that matches the class
    desktop_file=$(grep -ilR "StartupWMClass=${class}" /usr/share/applications ~/.local/share/applications 2>/dev/null | head -n 1)

    if [[ -n "$desktop_file" ]]; then
        # Extract the Icon field from the .desktop file
        icon_name=$(grep -m1 '^Icon=' "$desktop_file" | cut -d= -f2)
        icons+=("$icon_name")
    else
        # If no .desktop found, just return the class as a fallback
        icons+=("$class")
    fi
done

# Output unique icon names
printf "%s\n" "${icons[@]}" | sort -u
