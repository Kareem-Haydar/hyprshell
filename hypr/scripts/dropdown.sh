#!/bin/bash

TERM_TITLE="kitty_dropdown"
TMUX_SESSION="dropdown"


if hyprctl clients | grep -iq "$TERM_TITLE"; then
  pkill -f "kitty.*--class=$TERM_TITLE"
else
  kitty --title "$TERM_TITLE" --class="$TERM_TITLE" --override confirm_os_window_close=0 tmux new-session -As "$TMUX_SESSION" &
fi
