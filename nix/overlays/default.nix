{ pkgs, inputs, lib, pkgs-stable, ... }: {
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    # (import ./fingerprint.nix)
    (import ./pop-shell.nix)
    (import ./cpu-freq-monitor.nix)
    (import ./noise-suppression-for-voice.nix inputs)
    (final: prev: {
      simply-workspaces =
        inputs.simply-workspaces.defaultPackage."${final.system}";
    })
    inputs.nur.overlay
    # (final: prev: {
    #   gnome = pkgs-stable.gnome3;
    #   desktops.gnome = ({config, pkgs, lib }: pkgs-stable.desktops.gnome3 { inherit config lib; pkgs = pkgs-stable; });
    # })
    (final: prev: {
      parsec = prev.stdenv.mkDerivation {
        name = "parsec-gaming";
        src = prev.fetchurl {
          url = "https://builds.parsecgaming.com/package/parsec-linux.deb";
          sha256 = "1hfdzjd8qiksv336m4s4ban004vhv00cv2j461gc6zrp37s0fwhc";
        };
        phases = [ "buildPhase" "preFixup" ];
        buildInputs = with prev; [
          dpkg
          stdenv.cc.cc.lib
          # xorg.libX11 # libX11.so.6
          xorg.libXi # libXi.so.6
          libGL # libGL.so.1
          xorg.libXcursor # libXcursor.so.1
          alsa-lib # libasound.so.2
          libudev # libudev.so.1
          openssl
        ];
        nativeBuildInputs = [ prev.autoPatchelfHook ];
        buildPhase = ''
          mkdir -p $out
          dpkg-deb -x $src $out

          # Fix desktop file
          sed -i "s|/usr|$out|g" $out/usr/share/applications/parsecd.desktop

          # dpkg-deb makes $out group-writable, which nix doesn't like
          chmod 755 $out
          mv $out/usr/* $out
          rmdir $out/usr
        '';
        preFixup = with prev;
          let
            libPath = lib.makeLibraryPath [
              stdenv.cc.cc.lib
              zsnes # libX11.so.6
              xorg.libXi # libXi.so.6
              libGL # libGL.so.1
              xorg.libXcursor # libXcursor.so.1
              alsa-lib # libasound.so.2
              libudev # libudev.so.1
              openssl
              libglvnd #
              prev.stdenv.cc.cc.lib
              prev.gcc
              prev.gcc6
              prev.glibc
              prev.libGL
              alsaLib
              cups
              dbus
              fontconfig
              freetype
              libGL
              
              libva
              libxkbcommon
              nas
              stdenv.cc.cc.lib
              vulkan-loader

              xorg.libXScrnSaver
              xorg.libXcursor
              xorg.libXext

              xorg.libXinerama
              xorg.libXrandr
              xorg.libXrender
              xorg.libXxf86vm
              xorg.libxcb
            ];
          in ''
            echo ${libPath}
            # --add-needed libX11.so.6
            patchelf \
            --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
            --set-rpath "${libPath}" \
            $out/bin/parsecd

            patchelf --add-needed parsecd-150-28.so $out/bin/parsecd 
            patchelf --add-needed libX11.so.6 $out/bin/parsecd
            patchelf --add-needed libXi.so.6 $out/bin/parsecd
            patchelf --add-needed libXi.so.6 $out/bin/parsecd
            patchelf --add-needed libGL.so.1 $out/bin/parsecd
            patchelf --add-needed libXcursor.so.1 $out/bin/parsecd
            patchelf --add-needed libasound.so.2 $out/bin/parsecd
            patchelf --add-needed libudev.so.1 $out/bin/parsecd
            patchelf --add-needed libcrypto.so.1.1 $out/bin/parsecd
          '';
      };
    })
  ];
}

          # --add-needed libX11.so.6 \
          #   --add-needed libXi.so.6 \ 
          #   --add-needed libGL.so.1 \ 
          #   --add-needed libXcursor.so.1 \ 
          #   --add-needed libasound.so.2 \ 
          #   --add-needed libudev.so.1 \ 
          #   --add-needed libcrypto.so.1.0.0 \ 

# libc6 (>= 2.17),
#   libgcc1 (>= 1:3.0),
#   libgl1-mesa-glx | libgl1,
#   libsm6,
#   libstdc++6 (>= 5.2),
#   libx11-6,
#   libxxf86vm1
# Version: 150-28
