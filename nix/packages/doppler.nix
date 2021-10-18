{ inputs, pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "doppler";
  uuid = "doppler";
  version = "1.0.0";
  src = pkgs.fetchurl {
    url = "https://cli.doppler.com/download?os=Linux&arch=amd64&format=tar";
    sha256 = "sha256-TTwgoWmRkLlDFhK6LP7zcoyJwACEsPp9dqb/9p3gTPs=";
    name = "download.tar";
  };
  installPhase = ''
    cd ../
    mkdir -p $out/bin $out/completions
    cp doppler $out/bin/doppler
    chmod +x $out/bin/doppler
    cp -r completions/doppler.zsh $out/completions/_doppler
  '';
}
