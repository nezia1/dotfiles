#!/bin/sh
wallpaper=$(ls "$HOME/".wallpapers/** | shuf -n 1)

cat << EOF > ~/.config/hypr/hyprpaper.conf
preload = $wallpaper
wallpaper = eDP-1, $wallpaper
EOF
