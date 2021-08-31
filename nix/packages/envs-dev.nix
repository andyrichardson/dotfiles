{ pkgs }:
let
  # Monolithic dev env
  env = (pkgs.buildFHSUserEnv {
    name = "dev";
    targetPkgs = pkgs:
      with pkgs; [
        # Libs and shizz
        atk
        at_spi2_atk
        at_spi2_core
        binutils
        cairo
        cups
        dbus
        openssl
        stdenv.cc.cc
        udev
        expat
        freetype
        gdk_pixbuf
        git
        glib
        glibc
        gtk3
        gnumake
        gnupg
        http-parser
        icu
        libxkbcommon
        libuv
        nspr
        nss
        pango
        pkg-config
        stdenv.cc.cc.lib
        unzip
        which
        zip
        zlib
        zsh

        # Audio libs
        alsaLib
        pulseaudio
        libpulseaudio
        pipewire

        # Video libs
        mesa
        ffmpeg
        libdrm
        libGL
        libva.out

        # Xorg
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
        xorg.libxshmfence
        xorg.xauth
      ];
    runScript = "zsh";
  });

  derivation = pkgs.stdenv.mkDerivation {
    name = "fhs-dev-env";
    version = "3";
    src = builtins.path { path = ./.; };
    nativeBuldInputs = [ env ];
    installPhase = ''
      mkdir -p $out/bin
      cp -r ${env}/bin/dev $out/bin/dev
    '';
  };
in derivation.overrideAttrs (oldAttrs: {
  passthru = {
    shell = pkgs.mkShell {
      buildInputs = [ derivation ];
      shellHook = ''
        exec dev
      '';
    };
  };
})
