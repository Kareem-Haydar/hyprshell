#!/bin/bash

user="$USER"

sudo pacman -S neovim kitty hyprland tmux unzip npm nodejs zoxide swww python-pywal zsh fzf ripgrep fd bat clang --noconfirm

function remove_symlink_if_exists() {
  if [[ -L "$1" ]]; then
    echo "Removing symlink: $1"
    rm "$1"
  fi
}

function update_dotfiles() {
  remove_symlink_if_exists "${HOME}/.zshrc"

  echo "Creating symlink: ${HOME}/.zshrc"
  ln -sf "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"

  remove_symlink_if_exists "${HOME}/.config/nvim"

  echo "Creating symlink: ${HOME}/.config/nvim"
  ln -sf "${HOME}/dotfiles/nvim" "${HOME}/.config/nvim"

  remove_symlink_if_exists "${HOME}/.config/hypr"

  echo "Creating symlink: ${HOME}/.config/hypr"
  ln -sf "${HOME}/dotfiles/hypr" "${HOME}/.config/hypr"

  remove_symlink_if_exists "${HOME}/.config/kitty"

  echo "Creating symlink: ${HOME}/.config/kitty"
  ln -sf "${HOME}/dotfiles/kitty" "${HOME}/.config/kitty"

  remove_symlink_if_exists "${HOME}/.config/tmux"

  echo "Creating symlink: ${HOME}/.config/tmux"
  ln -sf "${HOME}/dotfiles/tmux" "${HOME}/.config/tmux"

  # Manually check and remove system-wide symlink
  if [[ -L /usr/bin/sys-maintenance ]]; then
    echo "Removing symlink: /usr/bin/sys-maintenance"
    sudo rm /usr/bin/sys-maintenance
  fi

  echo "Creating system-wide symlink: /usr/bin/sys-maintenance"
  sudo ln -sf "${HOME}/dotfiles/sys-maintenance" /usr/bin/sys-maintenance
}

update_dotfiles
