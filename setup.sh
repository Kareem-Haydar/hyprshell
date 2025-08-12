#!/bin/bash

clear

echo "
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░ ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓████████▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓████████▓▒░ 

"
cd $HOME

echo "Welcome to HyprShell, * denotes default selection"

echo "-----Dotfiles Setup-----"

echo "[1]* Automatically backup your current config"
echo "[2]  Skip automatic backup"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then 
  echo "Backing up current config..."
  cp -r $HOME/.config $HOME/Documents/config-backup-$(date +%Y-%m-%d-%H-%M-%S)
fi

echo "Removing old config..."
rm -rf ~/.config/hypr
rm -rf ~/.config/kitty
rm -rf ~/.config/tmux
rm -rf ~/.config/nvim
rm -f  ~/.zshrc
rm -rf ~/.zsh

echo "Cloning new dotfiles..."
if [[ -d hyprshell ]]; then
  rm -rf hyprshell
fi

git clone https://github.com/Kareem-Haydar/hyprshell.git
cd hyprshell

echo ""

echo "-----Font Setup-----"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing fonts..."

  sudo pacman -S nerd-fonts --noconfirm
fi

echo "-----DE Setup-----"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing hyprland..."

  sudo pacman -S hyprland hypridle --noconfirm
  cp -r hypr ~/.config/

  echo "Installing quickshell..."

  paru -S quickshell --noconfirm
  cp -r quickshell ~/.config/
fi

echo ""

echo "-----Terminal Setup-----"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing kitty..."

  sudo pacman -S kitty --noconfirm
  cp -r kitty ~/.config/

  echo "Installing tmux..."

  sudo pacman -S tmux --noconfirm
  cp -r tmux ~/.config/
fi

echo ""

echo "-----Shell Setup-----"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing zsh..."

  sudo pacman -S zsh --noconfirm
  cp -r .zshrc ~/


  mkdir -p ~/.zsh
  cd .zsh

  git clone https://github.com/zsh-users/zsh-autosuggestions.git 
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

  cd $HOME
fi

echo ""

echo "-----Neovim Setup-----"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing neovim..."

  sudo pacman -S neovim --noconfirm
  cp -r nvim ~/.config/
fi

echo ""

echo "Would you like to install the system maintainance script?"
echo ""
echo "[1]* Install"
echo "[2]  Skip"
echo "[q]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "q" ]]; then
  exit 0
fi

if [[ $choice == "1" || $choice == "" ]]; then
  echo "Installing system maintenance script..."

  sudo cp sys-maintenance /usr/bin
fi

echo ""

echo "Cleaning up..."

cd $HOME
rm -rf hyprshell

echo "Installation Complete!"
echo "Please restart your system!"
echo ""
echo "[1]* Reboot"
echo "[2]  Quit"

read -p "Select: " choice
echo ""

if [[ $choice == "1" ]]; then
  reboot
fi
