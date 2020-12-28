{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.tmux}/bin/tmux";
      };
    };
  };
}