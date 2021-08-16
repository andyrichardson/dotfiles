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
      (lib.getLib openssl)
      (lib.getLib stdenv.cc.cc)
      (lib.getLib udev)
      git
      glibc
      gnumake
      gnupg
      http-parser
      icu
      libuv
      libuv
      nodejs
      openjdk
      openssl
      openssl.dev
      perl
      pkg-config
      python2Full
      (python39Full.withPackages (p: with p; [ pip setuptools ]))
      python39Packages.fonty
      stdenv.cc.cc.lib
      unzip
      which
      zip
      zlib
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
})
