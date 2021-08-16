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
    nvim-coc = {
      url = "github:neoclide/coc.nvim";
      flake = false;
    };
    nvim-coc-git = {
      url = "github:neoclide/coc-git";
      flake = false;
    };
    nvim-coc-json = {
      url = "github:neoclide/coc-json";
      flake = false;
    };
    nvim-coc-prettier = {
      url = "github:neoclide/coc-prettier";
      flake = false;
    };
    nvim-coc-tsserver = {
      url = "github:neoclide/coc-tsserver";
      flake = false;
    };
    nvim-onedark = {
      url = "github:joshdick/onedark.vim";
      flake = false;
    };
    nvim-which-key = {
      url = "github:spinks/vim-leader-guide";
      flake = false;
    };
    nvim-nerd-commenter = {
      url = "github:preservim/nerdcommenter";
      flake = false;
    };
    rofi-themes = {
      url = "github:Murzchnvok/rofi-collection";
      flake = false;
    };
    powerline = {
      url = "github:powerline/powerline";
      flake = false;
    };
    pulse-noise-suppression-for-voice = {
      url = "github:werman/noise-suppression-for-voice";
      flake = false;
    };
    simply-workspaces.url = "github:andyrichardson/simply-workspaces";
    shade-inactive-windows = {
      url = "github:hepaajan/shade-inactive-windows";
      flake = false;
    };
    pop-shell = {
      url = "github:andyrichardson/shell";
      flake = false;
    };
    gtk-title-bar = {
      url = "github:velitasali/gtktitlebar";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    nix-node.url = "github:andyrichardson/nix-node";
    nur.url = "github:nix-community/NUR";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {
      # OS configuration
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit inputs;
          pkgs-stable = nixpkgs.legacyPackages.${system};
          username = "andy";
        };
        modules = [
          nixos-hardware.nixosModules.dell-xps-15-9500
          ./overlays
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              username = specialArgs.username;
            };
            home-manager.users.${specialArgs.username} =
              import ./home/default.nix;
          }
        ];
      };

      packages.x86_64-linux.devEnv = (import ./envs {
        inherit inputs;
        pkgs = nixpkgs.legacyPackages.${system};
      }).devEnv.env;
    };
}

