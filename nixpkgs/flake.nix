{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  
  outputs = { home-manager, nixpkgs, darwin, ... }: {
    darwinConfigurations."macOS" = darwin.lib.darwinSystem {
      modules = [ darwin.darwinModules.simple home-manager.darwinModules.home-manager (import ./home.nix) ];
    };

    defaultPackage = (darwin.lib.darwinSystem {
      modules = [ darwin.darwinModules.simple home-manager.darwinModules.home-manager (import ./home.nix) ];
    }).system;
  };
}


# {
#   description = "Example darwin system flake";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
#     darwin.url = "github:lnl7/nix-darwin";
#     darwin.inputs.nixpkgs.follows = "nixpkgs";
#   };

#   outputs = { self, darwin, nixpkgs }:
#   let
#     configuration = import ./darwin-configuration.nix;
#   in
#   {
#     # Build darwin flake using:
#     # $ darwin-rebuild build --flake ./modules/examples#darwinConfigurations.simple.system \
#     #       --override-input darwin .
    # darwinConfigurations."MacBook-Pro" = darwin.lib.darwinSystem {
    #   modules = [ configuration darwin.darwinModules.simple ];
    # };

#     # Expose the package set, including overlays, for convenience.
#     darwinPackages = self.darwinConfigurations."MacBook-Pro".pkgs;
#   };