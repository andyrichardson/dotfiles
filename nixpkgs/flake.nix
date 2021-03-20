{
  description = "NixOS configuration";
  inputs = {
    # zsh Plugins
    zsh-node-path = {
      url = "github:andyrichardson/zsh-node-path";
      flake = false;
    };
    zsh-completions = {
      url = "github:zsh-users/zsh-completions";
      flake = false;
    };
    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
    };
    zsh-nvm = {
      url = "github:lukechilds/zsh-nvm";
      flake = false;
    };
    zsh-better-npm-completion = {
      url = "github:lukechilds/zsh-better-npm-completion";
      flake = false;
    };
    zsh-autoswitch-virtualenv = {
      url = "github:MichaelAquilina/zsh-autoswitch-virtualenv";
      flake = false;
    };
    zsh-powerline = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
    zsh-history-substring-search = {
      url = "github:zsh-users/zsh-history-substring-search";
      flake = false;
    };
    # Nvim plugins
    nvim-nerdtree = {
      url = "github:preservim/nerdtree";
      flake = false;
    };
    nvim-prettier = {
      url = "github:prettier/vim-prettier";
      flake = false;
    };
    powerline = {
      url = "github:powerline/powerline";
      flake = false;
    };
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs: {
    defaultPackage.x86_64-darwin = (inputs.darwin.lib.darwinSystem {
      inputs = { inherit inputs; };
      modules = [ 
        ./overlays/default.nix
        ./system/fonts.nix
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            inherit inputs;
            username = "andyrichardson"; 
          };
          home-manager.users.andyrichardson = import ./home/default.nix;
        }
      ];
    }).system;
    
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./overlays/default.nix
        ./system/configuration.nix
        ./system/fonts.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            inherit inputs;
            username = "demo"; 
          };
          home-manager.users.demo = import ./home/default.nix;
        }
      ];
    };
  };
}
