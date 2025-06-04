if hyprctl clients | grep -iq "kitty_dropdown"; then
  echo "Window exists"
else
  echo "Window does not exist"
fi
