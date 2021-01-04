{
  description = "NixOS configuration";
  inputs = {
    antigen = {
      url = "github:zsh-users/antigen/v2.2.3";
      flake = false;
    };
    # ZSH Plugins
    zsh-node-path = {
      url = "github:andyrichardson/zsh-node-path";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  

  outputs = { antigen, zsh-node-path, home-manager, nixpkgs, darwin, ... }: {
    defaultPackage.x86_64-darwin = (darwin.lib.darwinSystem {
      inputs = { inherit home-manager nixpkgs darwin antigen; };
      modules = [ 
        home-manager.darwinModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users.andyrichardson = import ./home.nix { inherit antigen zsh-node-path; };
        }
      ];
    }).system;
  };
}
