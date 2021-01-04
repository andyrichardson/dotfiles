flakes: { config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.tmux}/bin/tmux";
      };
      font = {
        normal = {
          family = "DejaVuSansMono Nerd Font";
        };
      };
    };
  };
}