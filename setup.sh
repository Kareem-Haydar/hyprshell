#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

pacman -S neovim kitty hyprland tmux unzip npm nodejs zoxide swww python-pywal zsh fzf ripgrep fd bat clang --noconfirm

function remove_symlink_if_exists() {
  if [[ -L "$1" ]]; then
    echo "Removing symlink: $1"
    rm "$1"
  fi
}

function update_dotfiles() {
  remove_symlink_if_exists ~/.zshrc
  ln -sf ~/dotfiles/.zshrc ~/.zshrc

  remove_symlink_if_exists ~/.config/nvim
  ln -sf ~/dotfiles/nvim ~/.config/nvim

  remove_symlink_if_exists ~/.config/hypr
  ln -sf ~/dotfiles/hypr ~/.config/hypr

  remove_symlink_if_exists ~/.config/kitty
  ln -sf ~/dotfiles/kitty ~/.config/kitty

  remove_symlink_if_exists ~/.config/tmux
  ln -sf ~/dotfiles/tmux ~/.config/tmux

  remove_symlink_if_exists /usr/bin/sys-maintenance
  ln -sf ~/dotfiles/sys-maintenance /usr/bin/sys-maintenance
}

update_dotfiles
