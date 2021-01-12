flakes: { config, pkgs, ... }:
{
  # home.file.".config/powerline/config.json".text = builtins.toJSON {
  #     test = "hi";
  # };
  # home.packages = [
  #   (pkgs.python38Packages.buildPythonPackage rec {
  #     version  = "latest";
  #     pname = "powerline";

  #     src = flakes.powerline;
  #     propagatedBuildInputs = [
  #       pkgs.socat
  #       pkgs.python38Packages.psutil
  #       pkgs.python38Packages.hglib
  #       pkgs.python38Packages.pygit2
  #       pkgs.python38Packages.pyuv
  #     ];

  #     # tests are travis-specific
  #     doCheck = false;

  #     postInstall = ''
  #       install -dm755 "$out/share/fonts/OTF/"
  #       install -dm755 "$out/etc/fonts/conf.d"
  #       install -m644 "font/PowerlineSymbols.otf" "$out/share/fonts/OTF/PowerlineSymbols.otf"
  #       install -m644 "font/10-powerline-symbols.conf" "$out/etc/fonts/conf.d/10-powerline-symbols.conf"
  #       install -dm755 "$out/share/fish/vendor_functions.d"
  #       install -m644 "powerline/bindings/fish/powerline-setup.fish" "$out/share/fish/vendor_functions.d/powerline-setup.fish"
  #       cp -ra powerline/bindings/{bash,shell,tcsh,tmux,vim,zsh} $out/share/
  #       rm $out/share/*/*.py
  #     '';
  #   })
  # ];
}

