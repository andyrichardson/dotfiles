{ config, pkgs, ... }:

with import ../config/colors.nix;

{
  programs.alacritty = {
    enable = true;
    settings = {
      startup_mode = "Fullscreen";
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      font = {
        size = 12;
        normal = {
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