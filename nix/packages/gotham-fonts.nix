{ inputs, pkgs, ... }:
with pkgs;
stdenv.mkDerivation {
  pname = "gotham-fonts";
  version = "1.0.0";
  nativeBuildInputs = [ pkgs.unzip ];
  src = pkgs.fetchurl {
    url = "https://dl.freefontsfamily.com/download/gotham-font";
    sha256 = "1lha878jkybgqkfhiam01zfjs8xljq2kw92ywdx7w64mvhcrzmj5";
    name = "download.zip";
  };
  installPhase = ''
    ls
    # OpenType
    mkdir -p $out/share/fonts/opentype
    cp *.otf $out/share/fonts/opentype
    ls $out/share/fonts/opentype

    # TrueType
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype
    ls $out/share/fonts/truetype
  '';
}
