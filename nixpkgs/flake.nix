{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  

  outputs = { home-manager, nixpkgs, darwin, ... }: {
    defaultPackage.x86_64-darwin = (darwin.lib.darwinSystem {
      inputs = { inherit home-manager nixpkgs darwin; };
      modules = [ 
        home-manager.darwinModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users.andyrichardson = (import ./. + "/home.nix");
        }
      ];
    }).system;
    #     home-manager.darwinModules.home-manager
    #     {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       home-manager.users.andyrichardson = {
    #           programs.git = {
    #             enable = true;
    #             userName = "Test Richardson";
    #             userEmail = "TEST";
    #           };
    #         # programs.zsh = {
    #         #   enable = true;
    #         #   # oh-my-zsh = {
    #         #   #   enable = true;
    #         #   #   plugins = [
    #         #   #     "npm"
    #         #   #     "gitfast"
    #         #   #     "autojump"
    #         #   #   ];
    #         #   #   theme = "agnoster";
    #         #   # };
    #         #   # plugins = [
    #         #   #   {
    #         #   #     name = "zsh-nix-shell";
    #         #   #     file = "antigen.zsh";
    #         #   #     src = nixpkgs.fetchFromGitHub {
    #         #   #       owner = "zsh-users";
    #         #   #       repo = "antigen";
    #         #   #       rev = "v2.2.3";
    #         #   #       sha256 = "1hqnwdskdmaiyi1p63gg66hbxi1igxib6ql8db3w950kjs1cs7rq";
    #         #   #     };
    #         #   #   }
    #         #   # ];
    #         #   initExtra = ''
    #         #     ## "initExtra" in zsh.nix
    #         #     # Setup plugins
    #         #     antigen bundle unixorn/autoupdate-antigen.zshplugin
    #         #     antigen bundle zsh-users/zsh-completions
    #         #     antigen bundle zsh-users/zsh-autosuggestions
    #         #     antigen bundle zsh-users/zsh-syntax-highlighting
    #         #     antigen bundle chrissicool/zsh-256color
    #         #     antigen bundle amstrad/oh-my-matrix
    #         #     antigen bundle lukechilds/zsh-nvm
    #         #     antigen bundle lukechilds/zsh-better-npm-completion
    #         #     antigen bundle andyrichardson/zsh-node-path
    #         #     antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
    #         #     antigen apply
    #         #   '';
    #         # };
    #       };
    #     }
    #   ];
    # }).system;
    # defaultPackage = (darwin.lib.darwinSystem {
    #   modules = [
    #     darwin.darwinModules.simple
        # home-manager.darwinModules.home-manager {
        #   home.packages = [
        #     nixpkgs.htop
        #     nixpkgs.docker
        #     # pkgs.update-nix-fetchgit
        #   ];
        # }
    #   ];
    # }).system;
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