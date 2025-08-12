#!/bin/bash

if [[ -z "$1" ]]; then
  pidof swww-daemon || swww-daemon 
  python ~/dotfiles/shell/wallpaper/generator.py -d "$WALLPAPER"
  swww img "$WALLPAPER"
  wal -i "$WALLPAPER"

  exit 0
fi

pidof swww-daemon || swww-daemon 
python ~/dotfiles/shell/wallpaper/generator.py -d "$1"
swww img "$1"
wal -i "$1"
