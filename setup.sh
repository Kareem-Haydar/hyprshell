#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

pacman -S neovim kitty hyprland tmux unzip npm nodejs zoxide swww python-pywal zsh fzf ripgrep fd bat clang --noconfirm

function symlink_config() {
  ln -sf ~/dotfiles/.zshrc ~/.zshrc > /dev/null 2>&1
  ln -sf ~/dotfiles/nvim ~/.config/nvim > /dev/null 2>&1
  ln -sf ~/dotfiles/hypr ~/.config/hypr > /dev/null 2>&1
  ln -sf ~/dotfiles/kitty ~/.config/kitty > /dev/null 2>&1
  ln -sf ~/dotfiles/tmux ~/.config/tmux > /dev/null 2>&1
  ln -sf ~/dotfiles/sys-maintenance.sh /usr/bin > /dev/null 2>&1
}

symlink_config

#inotifywait -m -r -e modify,create,delete --format '%w%f' ~/dotfiles 2>/dev/null | while read change; do
#  symlink_config
#done
