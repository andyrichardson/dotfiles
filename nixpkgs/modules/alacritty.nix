{ config, pkgs, ... }:

with import ../colors.nix;

{
  programs.alacritty = {
    enable = true;
    settings = {
      # shell = {
      #   program = "${pkgs.tmux}/bin/tmux";
      # };
      font = {
        size = 14;
        normal = {
          # family = "DejaVuSansMono Nerd Font";
          family = "DroidSansMono Nerd Font";
        };
      };
      colors = {
        primary = {
          background = background;
          foreground = foreground;
        };

        normal = {
          black = black;
          red = red;
          green = green;
          yellow = yellow;
          blue = blue;
          magenta = magenta;
          cyan = cyan;
          white = white;
        };
        bright = {
          black = brightBlack;
        };
      };
    };
  };
}