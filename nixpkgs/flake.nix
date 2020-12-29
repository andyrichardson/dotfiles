{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  
  outputs = { home-manager, nixpkgs, ... }: {
    defaultPackage.x86_64-darwin = home-manager.darwinModules.home-manager;
  };
}