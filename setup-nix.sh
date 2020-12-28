#!/bin/bash

# Add home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install

# $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Copy config and make smlink for changes
# cp -r nixpkgs ~/.config
# ln -s ~/.config/nixpkgs .