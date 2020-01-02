## About

This is a collection of my config files and setup scripts. Feel free to use and redistribute!

## Pre-installations

Configure root password (for single user mode)

    su

## Desktop Environment

### Key remapping

    cp home/.Xmodmap ~/

### DPI scaling

For macbook pro / HIDPI displays

    echo "Xft.dpi: 192" >> ~/.Xresources

## Tools

## Editors

### VSCode

Install

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf install code

Copy config

    cp home/.config/Code/User/settings.json ~/.config/Code/User/

Install extensions

    cat home/extensions.list | xargs -L1 code --install-extension
