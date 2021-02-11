#!/bin/bash

# Install nix (macos) - skip daemon arg if issues
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon

# (optional)
. /etc/static/bashrc

# Add flakes
nix-env -iA nixpkgs.nixFlakes

# Add flake to globals
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Install nix darwin
mkdir -p /tmp/nix-darwin
cd /tmp/nix-darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

# Build and deploy env
cd -
nix build --impure
sudo ./result/activate

# Run this to get PATH working
. /etc/static/bashrc