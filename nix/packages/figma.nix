{ inputs, pkgs, ... }:
with pkgs;
let
  desktop-item = makeDesktopItem {
    name = "Figma";
    desktopName = "Figma";
    exec = "figma";
    icon = "figma-linux";
  };
  # Figma executable (can't run outside of FHS)
  figma-exec = stdenv.mkDerivation rec {
    pname = "figma-exec";
    version = "0.8.1";
    src = pkgs.fetchurl {
      url =
        "https://github.com/Figma-Linux/figma-linux/releases/download/v0.8.1/figma-linux_0.8.1_linux_amd64.zip";
      sha256 = "sha256-LqcjFLQeEQx/3HFy0mPoIynFy704omYVxv42IsY7s8k=";
    };
    dontStrip = true;
    buildInputs = [
      unzip
      nodejs-14_x
      rustc
      cargo
      tree
      (python2Full.withPackages (p: with p; [ setuptools ]))
      freetype
      appimagekit
      p7zip
      squashfsTools
      glibc
      zlib
      bash
    ];
    unpackPhase = ''
      runHook preUnpack
      mkdir output
      unzip $src -d output
      runHook postUnpack
    '';
    installPhase = ''
      APPDIR=$out/etc/figma-linux
      # patchShebangs output

      # Copy application to etc
      mkdir -p $out/etc/figma-linux
      cp -r output/. $APPDIR

      # Add icons
      for size in 24 36 48 64 72 96 128 192 256 384 512; do
        mkdir -p "$out/share/icons/hicolor/''${size}x''${size}/apps"
        cp -rf "$APPDIR/icons/''${size}x''${size}.png" "$out/share/icons/hicolor/''${size}x''${size}/apps/figma-linux.png"
      done
      mkdir -p "$out/share/icons/hicolor/scalable/apps"
      cp -rf "$APPDIR/icons/scalable.svg" "$out/share/icons/hicolor/scalable/apps/figma-linux.svg"

      # Link binary
      mkdir -p $out/bin
      ln -s $out/etc/figma-linux/figma-linux $out/bin/figma

      # Link desktop item
      mkdir -p $out/share/applications
      ln -s ${desktop-item}/share/applications/* $out/share/applications
    '';
  };
  figma-fhs = buildFHSUserEnv {
    name = "figma-fhs";
    targetPkgs = pkgs: [
      figma-exec
      alsaLib
      at_spi2_atk
      at_spi2_core
      atk
      avahi
      brotli
      cairo
      cups
      dbus
      expat
      freetype
      pango
      gcc
      glib
      glibc
      gdk_pixbuf
      gtk3
      icu
      libxkbcommon
      mesa
      ffmpeg
      libdrm
      libGL
      nss_3_53
      nspr
      udev
      xorg.libXdamage
      xorg.libXext
      xorg.libX11
      xorg.libXau
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXdmcp
      xorg.libXfixes
      xorg.libXrender
      xorg.libXrandr
      xorg.libxshmfence
      wayland
    ];
    runScript = "figma";
  };

in stdenv.mkDerivation {
  name = "figma";
  version = "0.8.1";
  src = builtins.path { path = ./.; };
  nativeBuildInputs = [ figma-fhs ];
  installPhase = ''
    # Add binary link
    mkdir -p $out/bin
    cp -r ${figma-fhs}/bin/figma-fhs $out/bin/figma

    # Link icons
    mkdir -p $out/share/icons
    cp -r ${figma-exec}/share/icons/. $out/share/icons/

    # Link desktop item
    mkdir -p $out/share/applications
    ln -s ${desktop-item}/share/applications/* $out/share/applications
  '';
}
