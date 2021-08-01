{ pkgs ? import <nixpkgs> { } }:
let
  # Xorg packages
  xorgGroup = (pkgs:
    with pkgs; [
      xorg.libXScrnSaver
      xorg.libXdamage
      xorg.libXinerama
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXi
      xorg.libXext
      xorg.libXtst
      xorg.libXfixes
      xorg.libXcursor
      xorg.libXrender
      xorg.libXrandr
      xorg.xauth
    ]);

  # Video/graphics/encoding packages
  videoGroup = pkgs: with pkgs; [ mesa ffmpeg libdrm libGL libva.out ];

  # Audio packages
  audioGroup = pkgs: with pkgs; [ alsaLib pulseaudio libpulseaudio pipewire ];

  # Miscellaneous OS dependencies
  miscGroup = pkgs:
    with pkgs; [
      cups
      expat
      libxkbcommon
      at_spi2_atk
      at_spi2_core
      dbus
      (lib.getLib dbus)
      gdk_pixbuf
      cairo
      pango
      glib
      glibc
      nspr
      atk
      nss
      gtk2
      gtk3
      gnome2.GConf
      zsh
    ];

  # Development libraries and tools
  buildToolsGroup = pkgs:
    with pkgs; [
      unzip
      which
      pkg-config
      zlib
      libuv
      (lib.getLib openssl)
      (lib.getLib stdenv.cc.cc)
      (lib.getLib udev)
      openssl
      http-parser
      icu
      stdenv.cc.cc.lib
      zlib
      libuv
      openssl.dev
      pkg-config
      python
      glibc
      nodejs
      python2
      python3
    ];

  # Monolithic dev environment
in (pkgs.buildFHSUserEnv {
  name = "dev";
  targetPkgs = pkgs:
    (pkgs.lib.concatMap (group: group pkgs) [
      xorgGroup
      videoGroup
      audioGroup
      miscGroup
      buildToolsGroup
    ]);
}).env
