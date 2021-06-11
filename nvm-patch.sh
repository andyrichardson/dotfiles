#!/usr/bin/env bash
export LIBRARY_PATH=$(nix eval -f '<nixos>' --raw 'stdenv.cc.cc.lib')/lib
nix-shell -p patchelf --run 'patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath $LIBRARY_PATH $(which node)'
#nix-shell -p patchelf --run 'echo $NIX_CC'

#Bnix eval -f '<nixos>' --raw stdenv.cc.cc
