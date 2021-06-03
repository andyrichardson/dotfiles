final: prev: {
  oem-somerville-melisa-meta = prev.stdenv.mkDerivation rec {
    pname = "oem-somerville-melisa-meta";
    version = "1.0.0";

    src = prev.fetchurl {
      url = "http://dell.archive.canonical.com/updates/pool/public/o/oem-somerville-melisa-meta/oem-somerville-melisa-meta_20.04ubuntu10_all.deb";
      sha256 = "IgrO+MSLHvw+0FsJ+9U+ttUypqihqhgL+pVT2zxlGTI=";
    };
    sourceRoot = ".";
    unpackCmd = "dpkg-deb -x $curSrc . && tree";
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      cp -r usr $out
    '';

    buildInputs = [
      prev.dpkg
      prev.tree
    ];
  };

  oem-somerville-meta = prev.stdenv.mkDerivation rec {
    pname = "oem-somerville-meta";
    version = "1.0.0";

    src = prev.fetchurl {
      url = "http://dell.archive.canonical.com/updates/pool/public/o/oem-somerville-meta/oem-somerville-meta_20.04ubuntu9_all.deb";
      sha256 = "4QST5o183PVCWQk0f2k+86W7SwNsGuKqimeR7FdJDb0=";
    };
    sourceRoot = ".";
    unpackCmd = "dpkg-deb -x $curSrc . && tree";
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      cp -r usr $out
    '';

    buildInputs = [
      prev.dpkg
      prev.tree
    ];
  };

  # libfprint-goodix = prev.stdenv.mkDerivation rec {
  #   pname = "oem-somerville-meta";
  #   version = "1.0.0";

  #   src = prev.fetchurl {
  #     url = "http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.6.orig.tar.gz";
  #     sha256 = "leOzM3CQifl0EGBYzdiKykNm4/nLOrBJQLRNTOu2AH0=";
  #   };
  #   sourceRoot = ".";
  #   unpackCmd = "tar xf $curSrc";
  #   dontConfigure = true;
  #   dontBuild = true;

  #   installPhase = ''
  #     cp -r libfprint-2-tod1-goodix-0.0.6/usr $out
  #     cp -r libfprint-2-tod1-goodix-0.0.6/lib $out
  #   '';

  #   buildInputs = [
  #     prev.dpkg
  #     prev.tree
  #   ];
  # };

  libfprint-2-tod1-goodix = prev.stdenv.mkDerivation rec {
    pname = "libfprint-2-tod1-goodix";
    version = "0.0.6";

    src = fetchgit {
      url = "https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/+git/libfprint-2-tod1-goodix";
      rev = "882735c6366fbe30149eea5cfd6d0ddff880f0e4"; # droped-lp1880058 on 2020-11-25
      sha256 = "sha256-Uv+Rr4V31DyaZFOj79Lpyfl3G6zVWShh20roI0AvMPU=";
    };

    buildPhase = ''
      patchelf \
        --set-rpath ${lib.makeLibraryPath [ libfprint-tod ]} \
        usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-0.0.6.so

      ldd usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-0.0.6.so
    '';

    installPhase = ''
      mkdir -p "$out/lib/libfprint-2/tod-1/"
      mkdir -p "$out/lib/udev/rules.d/"

      cp usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-$version.so "$out/lib/libfprint-2/tod-1/"
      cp lib/udev/rules.d/60-libfprint-2-tod1-goodix.rules "$out/lib/udev/rules.d/"
    '';

    passthru.driverPath = "/lib/libfprint-2/tod-1";

    meta = with lib; {
      description = "Goodix driver module for libfprint-2-tod Touch OEM Driver";
      homepage = "https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/+git/libfprint-2-tod1-goodix/";
      license = licenses.unfree;
      platforms = platforms.linux;
      maintainers = with maintainers; [ grahamc ];
    };
  }
}


