{ inputs, pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "gtk-title-bar";
  uuid = "gtktitlebar@velitasali.github.io";
  version = "1.0.0";
  src = inputs.gtk-title-bar;
  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions/
  '';
}
