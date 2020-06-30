#!/bin/bash
GIT_USER_NAME="Andy Richardson"
GIT_EMAIL="email@email.com"


# Setup git
setupGit() {
    echo "Configuring git"
    git config --global user.name $GIT_USER_NAME
    git config --global user.email $GIT_EMAIL
    git config --global push.default current
    git config --global pull.default current
}

# Setup terminator
setupTerminator() {
  sudo pacman -Sy --noconfirm terminator
  cp -r home/.config/terminator ~/.config/
}

# Setup zsh
setupZsh() {
  echo "Installing zsh"
  mkdir -p ~/.zsh

  # zsh
  sudo pacman -Sy --noconfirm zsh
  
  # Antigen package manager
  curl -L git.io/antigen > ~/.zsh/antigen.zsh

  # Copy config across
  cp home/.zshrc ~/.zshrc
}

# Setup tmux
setupTmux() {
  sudo pacman -Sy --noconfirm tmux
  cp home/.tmux.conf ~/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
  chsh -s /usr/bin/tmux
}

# Setup neovim
setupNeovim() {
  sudo pacman -Sy --noconfirm neovim python-pynvim

  # Install package manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  # Copy config
  cp -r home/.config/nvim ~/.config/
  cp home/.vimrc ~/
  nvim -c PlugInstall -c q -c q
}

setupGnomeShell() {
  ## Extensions
  git clone https://github.com/tomha/gnome-shell-extension-workspace-switcher ~/.local/share/gnome-shell/extensions/workspace-switcher@tomha.github.com
  pamac build --no-confirm gnome-shell-extension-pop-shell-git
  
  dconf write /org/gnome/shell/extensions/workspce-switcher/background-colour-active "'#bf3f3f00'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/background-colour-inactive "'#bf3f3f00'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/border-size-active 0
  dconf write /org/gnome/shell/extensions/workspce-switcher/border-size-inactive 0
  dconf write /org/gnome/shell/extensions/workspce-switcher/font-colour-active "'#ffffffff'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/font-colour-inactive "'#555753ff'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/font-colour-use-custom-active true
  dconf write /org/gnome/shell/extensions/workspce-switcher/mode "'ALL'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/padding-horizontal 5
  dconf write /org/gnome/shell/extensions/workspce-switcher/position "'LEFT'"
  dconf write /org/gnome/shell/extensions/workspce-switcher/show-names false

  ### Gnome Settings ###
  # Go to workspace
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"

  # Move focused window to workspace
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1 "['<Super><Shift>1']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2 "['<Super><Shift>2']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3 "['<Super><Shift>3']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4 "['<Super><Shift>4']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5 "['<Super><Shift>5']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6 "['<Super><Shift>6']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7 "['<Super><Shift>7']"
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8 "['<Super><Shift>8']"

  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left "['<Super><Control>Left', '<Super><Control>h']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left "['<Super><Control>Right', '<Super><Control>l']"

  dconf write /org/gnome/desktop/wm/preferences/focus-mode "'sloppy'"
  dconf write /org/gnome/mutter/dynamic-workspaces false
  dconf write /org/gnome/desktop/wm/preferences/num-workspaces 8
}

### Setup terminal
sudo pacman -Syyu --noconfirm pamac ttf-font-awesome zsh tmux neovim ttf-joypixels

### Install gnome shell (full)
sudo pacman -Syyu --noconfirm gnome-extra gdm manjaro-gnome-assets manjaro-gdm-theme manjaro-settings-manager
