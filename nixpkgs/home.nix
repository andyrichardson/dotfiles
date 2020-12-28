{ config, pkgs, ... }:

{
  imports = [
    (./. + "/modules/git.nix")
    (./. + "/modules/zsh.nix")
    (./. + "/modules/tmux.nix")
  ];

  programs.home-manager.enable = true;
  
  home.username = "andy";
  home.homeDirectory = "/home/andy";
  home.stateVersion = "21.03";
  home.sessionVariables = {
    EDITOR = "tmux";
  };

  home.packages = [
    pkgs.htop
    pkgs.docker
  ];

  # programs.zsh = {
  #   enable = true;
  # };
}
