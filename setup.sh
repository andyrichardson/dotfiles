#!/bin/bash
$GIT_USER_NAME="Andy Richardson"
$GIT_EMAIL="email@email.com"


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
  sudo dnf install -y terminator
  cp -r home/.config/terminator ~/.config/
}

# Setup zsh
setupZsh() {
  echo "Installing zsh"
  mkdir -p ~/.zsh

  # zsh
  sudo dnf install -y zsh
  
  # Antigen package manager
  curl -L git.io/antigen > ~/.zsh/antigen.zsh

  # Copy config across
  cp home/.zshrc ~/.zshrc
}

# Setup tmux
setupTmux() {
  # Fedora
  sudo dnf install tmux
  cp home/.tmux.conf ~/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
  chsh -s /usr/bin/tmux
}

# Setup neovim
setupNeovim() {
  sudo dnf -y install neovim
  sudo dnf -y install python2-neovim python3-neovim

  # Install package manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  # Copy config
  cp home/.config/nvim ~/.config/
  cp home/.vimrc ~/
  nvim -c PlugInstall -c q -c q
}

# Setup desktop environment
setupDesktopEnv() {
  # Install xfce, i3, rofi
  sudo dnf groupinstall -y "Xfce Desktop"
  sudo dnf copr enable fusion809/Rofi
  sudo dnf copr enable nforro/i3-gaps
  sudo dnf install -y i3-gaps nitrogen rofi jq


  # Install workspace plugin dependencies
  sudo dnf install -y intltool gtk3-devel gtk2-devel libxfce4ui-devel xfce4-panel-devel xfce4-dev-tools json-glib-devel
  curl -L https://github.com/altdesktop/i3ipc-glib/releases/download/v0.6.0/i3ipc-0.6.0.tar.gz | tar -xzv -C /tmp
  ( cd /tmp/i3ipc-0.6.0 && ./configure --prefix=/usr && make && sudo make install )


  # Install xfce i3 workspace plugin
  curl -L https://github.com/denesb/xfce4-i3-workspaces-plugin/releases/download/1.2.0/xfce4-i3-workspaces-plugin-1.2.0.tar.gz | tar -xzv -C /tmp
  ( cd /tmp/xfce4-i3-workspaces-plugin && ./configure --prefix=/usr && make && sudo make install )
  cd xfce4-i3-workspaces-plugin.tar.gz
  ./configure --prefix=/usr
  make
  sudo make install

  # Remove DE startup processes
  sudo sed -i -e 's/^xfwm4/# DISABLED: &/' /etc/xdg/xfce4/xinitrc 
  sudo sed -i -e 's/^xfdesktop/# DISABLED: &/' /etc/xdg/xfce4/xinitrc 

  # Copy config files across
  cp home/.config/autostart ~/.config/
  cp home/.config/xfce4 ~/.config/

  # Setup a
}