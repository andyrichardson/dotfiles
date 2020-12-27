{ config, pkgs, ... }:

{
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
    pkgs.antigen
  ];

  programs.git = {
    enable = true;
    userName = "Andy Richardson";
    userEmail = "email";
  };

  programs.zsh = {
    enable = true;
  };
}
