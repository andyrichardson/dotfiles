{ inputs, config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  programs.rofi = {
    enable = true;
    package =  pkgs.rofi.override { 
      plugins = [ pkgs.rofi-emoji ]; 
    };
    extraConfig = {
      modi = "drun,emoji";
      lines = 4;
    };
    # Theme sourced from - https://github.com/Murzchnvok/rofi-collection/blob/master/material/material.rasi
    theme = "material-override";
  };
  home.file.".config/rofi/material.rasi".source = "${inputs.rofi-themes}/material/material.rasi";
  # see here for override - https://github.com/Murzchnvok/rofi-collection/pull/2
  home.file.".config/rofi/material-override.rasi".text = ''
    @theme "material"
    element {
      orientation: horizontal;
    }

    element-icon {
      size: 1.2em;
    }
  '';
  home.packages = [
    pkgs.rofimoji
  ];
}