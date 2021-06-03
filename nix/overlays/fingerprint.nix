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
}

