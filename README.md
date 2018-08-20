## About

This is a collection of my config files for developing on Linux. It is assumed that the dnf/yum package managers are available.

## Pre-installations

Configure root password (for single user mode)

    su

Install development tools

    sudo dnf install @development-tools

## Terminal

Install fish shell ([source](https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A2&package=fish))

    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:2/Fedora_27/shells:fish:release:2.repo
    sudo dnf install fish

Install omf ([source](https://github.com/oh-my-fish/oh-my-fish))

    curl -L https://get.oh-my.fish | fish

Install omf packages

    omf install bobthefish node-binpath

Install powerline fonts

    sudo dnf install powerline-fonts

Install tmux

    sudo dnf install tmux
    cp home/.tmux.conf ~/

## Desktop Environment

Install i3 (gaps), compton and rofi

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


