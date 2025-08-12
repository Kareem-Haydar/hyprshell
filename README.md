# THIS IS NOWHERE NEAR COMPLETE, IF YOU TRY TO USE IT, IT WILL BREAK

# My dotfiles repository

## Contains configs for the following:
- kitty
- tmux
- neovim
- zsh
- hyprland
- quickshell
- system maintenance script (standalone `sys-maintenance` script)

## Installation
Before you install, make sure you have `paru` and `wget` installed at least
To install simply paste the following code into your terminal:

```bash
wget https://raw.githubusercontent.com/Kareem-Haydar/hyprshell/refs/heads/master/setup.sh
./setup.sh
```
You can also use the setup script to update the configs if you make any changes

## Other distros
If you are on a distro other than arch, you can install the following packages manually (package names may differ):

- `neovim`
- `kitty`
- `tmux`
- `zsh`
- `hyprland`
- `unzip`
- `npm`
- `nodejs`
- `zoxide`
- `swww`
- `pywal`
- `fzf`
- `ripgrep`
- `fd`
- `bat`
- `clang`
- `quickshell`

Next, clone the repo and copy the configs yourself (you can skip any configs you don't want):

```bash
git clone https://github.com/Kareem-Haydar/hyprshell.git
cd hyprshell

# ZSH requires zsh-syntax-highlighting and zsh-autosuggestions
# To use them, install them from GitHub and then copy them into ~/.zsh
cp -r .zshrc ~/

cp -r tmux ~/.config
cp -r kitty ~/.config

cp -r neovim ~/.config
cp -r hypr ~/.config
cp -r quickshell ~/.config

# The system maintenance script only works on CachyOS as of now
```

## Notes:
- As of now, the setrup script has currently only tested on Arch Linux (CachyOS) and only works on arch based distros, but you can manually install the packages
- If you decide to skip certain setps, it may break other parts (eg. the terminal (kitty) depends on the fonts) and you must change the configs yourself as of now
