## About

This is a collection of my config files and setup scripts. Feel free to use and redistribute!

## Pre-installations

Configure root password (for single user mode)

    su

Install development tools

    sudo dnf install @development-tools

## Keyboard wizardry (macOs)

Keyboard remappings

 * caps_lock => control
 * control + ; => control + b

Install Karabiner Elements ([source](https://pqrs.org/osx/karabiner/))

Copy config

```
    cp -r home/.config/karabiner ~/.config
```

## Terminal

### Gnome terminal

Set colors

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

### Fish shell

Install ([source](https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A2&package=fish))

    # Fedora
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:2/Fedora_27/shells:fish:release:2.repo
    sudo dnf install fish

    # macOS
    brew install fish

Install omf ([source](https://github.com/oh-my-fish/oh-my-fish))

    curl -L https://get.oh-my.fish | fish

Install omf packages

    omf install bobthefish node-binpath nvm

Install powerline fonts

    sudo dnf install powerline-fonts

### Tmux

Install

    # Fedora
    sudo dnf install tmux
    cp home/.tmux.conf ~/

    # macOS
    cat home/.tmux.conf | sed 's|/usr/bin/fish|/usr/local/bin/fish|g' > ~/.tmux.conf 

Install package manager

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### Git

Configure user info

    git config --global user.name "FIRST_NAME LAST_NAME"
    git config --global user.email "MY_NAME@example.com"

Configure push & pull policy

    git config --global push.default current
    git config --global pull.default current

## Desktop Environment

### i3wm

Install i3 (gaps) and rofi

    # Install packages
    sudo dnf copr enable gregw/i3desktop
    sudo dnf install i3-gaps rofi

    # Copy configs
    cp -r home/.config/i3 ~/.config
    cp -r home/.config/rofi ~/.config

Install compton

    sudo dnf install compton
    cp home/.config/compton.conf ~/.config

Install polybar

    sudo dnf install polybar
    cp -r home/.config/polybar ~/.config

## Tools

### Nvm

Install

    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

Install node version and set default

    nvm install 11
    nvm alias default 11

## Editors

### Neovim

Install

    # Fedora
    sudo dnf -y install neovim
    sudo dnf -y install python2-neovim python3-neovim

    # macOS
    brew install neovim

Install package manager

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Copy config

    cp home/.config/nvim ~/.config/

Copy .vimrc

    cp home/.vimrc ~/

Install plugins

    nvim -c PlugInstall -c q -c q

### VSCode

Install

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf install code

Copy config

    cp home/.config/Code/User/settings.json ~/.config/Code/User/

Install extensions

    cat home/extensions.list | xargs -L1 code --install-extension
