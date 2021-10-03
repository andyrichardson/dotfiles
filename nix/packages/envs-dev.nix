{ pkgs }:
let
  # Monolithic dev env
  env = (pkgs.buildFHSUserEnv {
    name = "dev";
    targetPkgs = pkgs:
      with pkgs; [
        # Prisma is ignoring binary target env vars
        (pkgs.stdenv.mkDerivation {
          name = "prisma-workaround";
          src = builtins.path { path = ./.; };
          installPhase = ''
            mkdir -p $out/etc
            touch $out/etc/alpine-release
          '';
        })
        # Libs and shizz
        appimagekit
        atk
        at_spi2_atk
        at_spi2_core
        cairo
        cmake
        cups
        dbus
        openssl
        #stdenv.cc.cc
        udev
        expat
        freetype
        brotli
        gcc-unwrapped
        binutils-unwrapped
        gdk_pixbuf
        git
        glib
        glibc

        # GJS packages
        graphene
        gtk3
        gtk4
        harfbuzz
        gobject-introspection
        gjs

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
        #stdenv.cc.cc.lib
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

        # Languages
        cargo
        rustc
        (python2Full.withPackages (p: with p; [ pip setuptools ]))
        (python39Full.withPackages (p: with p; [ pip setuptools ]))
      ];
    runScript = "zsh";
  });

  derivation = pkgs.stdenv.mkDerivation {
    name = "fhs-dev-env";
    version = "3";
    src = builtins.path { path = ./.; };
    nativeBuldInputs = [ env pkgs.wrapGAppsHook ];
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
