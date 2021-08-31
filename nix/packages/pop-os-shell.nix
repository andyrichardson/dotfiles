{ inputs, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "pop-os-shell";
  version = "1.5.0";
  uuid = "pop-shell@system76.com";

  src = inputs.pop-shell;

  nativeBuildInputs = [ pkgs.glib pkgs.nodePackages.typescript pkgs.gjs ];

  buildInputs = [ pkgs.gjs ];

  makeFlags = [
    "INSTALLBASE=$(out)/share/gnome-shell/extensions PLUGIN_BASE=$(out)/share/pop-shell/launcher SCRIPTS_BASE=$(out)/lib/pop-shell/scripts"
  ];

  postInstall = ''
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/floating_exceptions/main.js
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/color_dialog/main.js
  '';
}
