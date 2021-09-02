{ pkgs, ... }:
with pkgs;
let fonts = (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; });
in stdenv.mkDerivation {
  pname = "fonts";
  version = "1.0.0";
  src = ./.;
  buildDependencies = [ ];
  installPhase = ''
    mkdir -p $out
    cd ${fonts}
    pwd
    echo "INSTALL"
  '';
}
