{ pkgs, lib, inputs, username, ... }:

{
  imports = [
    ./alacritty.nix
    ./gnome.nix
    ./git.nix
    ./neovim.nix
    ./packages.nix
    ./powerline.nix
    ./rofi.nix
    ./tmux.nix
    ./vscode.nix
    ./zsh.nix
  ];

  home = {
    inherit username;
    stateVersion = "21.05";
    sessionVariables = {
      EDITOR = "nvim";
      NIC_CC = "${pkgs.gcc.out}";
    };

    file = {
      ".config/nixpkgs/config.nix".text = ''
        {
          allowUnfree = true;
        }
      '';
    };
  };

  programs.home-manager.enable = true;
}
