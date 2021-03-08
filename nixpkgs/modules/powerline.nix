{ config, pkgs, inputs, ... }:
{
  home.file.".config/powerline/config.json".text = builtins.toJSON {
      test = "hi";
  };
  home.file.".config/powerline/themes/tmux/default.json".text = builtins.toJSON {
    segments = {
      right = [];
    };
  };
  home.file.".config/powerline/colorschemes/tmux/default.json".text = builtins.toJSON {
    groups = {
      background = {
        fg = "red";
        bg = "black";
      };
      session = {
        fg = "white";
        bg = "blue";
      };
      window = {
        bg = "black";
        fg = "white";
      };
      "window:current" = {
        bg = "blue";
        fg = "white";
      };
      window_name = {
        bg = "blue";
        fg = "white";
      };
      active_window_status = {
        bg = "black";
        fg = "white";
      };
      "window:divider" = {
        bg = "black";
        fg = "white";
      };
      "session:prefix" = {
        bg = "red";
        fg = "white";
      };
    };
  };
  home.file.".config/powerline/colors.json".text = builtins.toJSON {
    colors = {
      blue = 4;
      red = 1;
      grey = 8;
      black = 0;
      white = 15;
    };
  };
  home.packages = [
    (pkgs.python38Packages.buildPythonPackage rec {
      version  = "latest";
      pname = "powerline";

      src = inputs.powerline;
      propagatedBuildInputs = [
        pkgs.socat
        pkgs.python38Packages.psutil
        pkgs.python38Packages.hglib
        pkgs.python38Packages.pygit2
        pkgs.python38Packages.pyuv
      ];

      # tests are travis-specific
      doCheck = false;

      postInstall = ''
        install -dm755 "$out/share/fonts/OTF/"
        install -dm755 "$out/etc/fonts/conf.d"
        install -m644 "font/PowerlineSymbols.otf" "$out/share/fonts/OTF/PowerlineSymbols.otf"
        install -m644 "font/10-powerline-symbols.conf" "$out/etc/fonts/conf.d/10-powerline-symbols.conf"
        install -dm755 "$out/share/fish/vendor_functions.d"
        install -m644 "powerline/bindings/fish/powerline-setup.fish" "$out/share/fish/vendor_functions.d/powerline-setup.fish"
        cp -ra powerline/bindings/{bash,shell,tcsh,tmux,vim,zsh} $out/share/
        rm $out/share/*/*.py
      '';
    })
  ];
}

