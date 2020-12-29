{ config, pkgs, ... }:

{
  imports = [
    (./. + "/modules/alacritty.nix")
    (./. + "/modules/git.nix")
    (./. + "/modules/tmux.nix")
    (./. + "/modules/vscode.nix")
    (./. + "/modules/zsh.nix")
  ];

  programs.home-manager.enable = true;
  
  home.username = "andyrichardson";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "21.03";
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    pkgs.htop
    pkgs.docker
    # pkgs.update-nix-fetchgit
  ];
}
