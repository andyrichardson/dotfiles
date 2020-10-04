#/bin/bash
# Note: Replace email below

######################
# Packages
######################
sudo apt update
sudo apt install -y \
  git build-essential curl python3 python3-pip autoconf

######################
# zsh
######################
sudo apt install -y zsh
mkdir -p ~/.zsh

curl -L git.io/antigen > ~/.zsh/antigen.zsh
cp home/.zshrc ~/.zshrc

######################
# tmux
######################
sudo apt install -y tmux
cp home/.tmux.conf ~/

mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
# chsh -s /usr/bin/tmux

######################
# neovim
######################
sudo apt install -y neovim
        
cp -r home/.config/nvim ~/.config/
cp home/.vimrc ~/

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall -c q -c q
pip3 install pynvim

######################
# git
######################
git config --global user.name "Andy Richardson"
git config --global user.email "[email]"

######################
# docker
######################
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker andy
pip3 install docker-compose

######################
# emoji
######################
sudo apt install -y fonts-emojione gnome-characters libglib2.0-dev rofi-dev
git clone https://github.com/Mange/rofi-emoji.git /tmp/rofi-emoji
cd /tmp/rofi-emoji
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
cd -
rm -rf /tmp/rofi-emoji

