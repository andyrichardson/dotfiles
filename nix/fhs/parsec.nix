{ pkgs ? import <nixpkgs> { } }:

pkgs.buildFHSUserEnv {
  name = "parsec";
  targetPkgs = pkgs:
    with pkgs; [
      xorg.libXScrnSaver
      xorg.libXdamage
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXi
      xorg.libXext
      xorg.libXfixes
      xorg.libXcursor
      xorg.libXrender
      xorg.libXrandr
      mesa
      cups
      expat
      ffmpeg
      libdrm
      libxkbcommon
      at_spi2_atk
      at_spi2_core
      dbus
      gdk_pixbuf
      gtk3
      cairo
      pango
      xorg.xauth
      glib
      nspr
      atk
      nss
      gtk2
      alsaLib
      gnome2.GConf
      unzip
      (lib.getLib udev)
    ];
}

# let
#   fhs = pkgs.buildFHSUserEnv {
#     name = "fhs-env";
#     targetPkgs = pkgs: with pkgs; [ hello ];

#     multiPkgs = pkgs: with pkgs; [ zlib ];
#     runScript = "bash";

#     #echo $TEST_EXPORT
#     profile = ''
#       export TEST_EXPORT='123abc'
#     '';

#   };

#   scriptExample = pkgs.writeShellScriptBin "script-example" ''
#     #!${pkgs.runtimeShell}
#       echo 'A bash script example!'
#   '';

# in pkgs.stdenv.mkDerivation {
#   name = "fhs-env-derivation";

#   # https://nix.dev/anti-patterns/language.html#reproducability-referencing-top-level-directory-with
#   src = builtins.path { path = ./.; };

#   nativeBuildInputs = [ fhs ];

#   installPhase = ''
#     mkdir --parent $out
#     cp -r ${fhs}/bin/fhs-env $out/fhs-env
#     cp -r ${scriptExample}/bin/script-example $out/script-example
#   '';
# }
