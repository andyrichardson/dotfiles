final: prev: {
  evo4-udev = prev.stdenv.mkDerivation {
    name = "evo4-udev";
    src = ./.;
    buildPhase = ''
      make PREFIX=$out install
      substituteInPlace $out/local/bin/evo4.sh --replace pactl ${prev.pulseaudioFull}/bin/pactl
      mkdir -p $out/bin
      mv $out/local/bin/evo4.sh $out/bin/evo4
    '';
    installPhase = ''
      echo "NOPE"
    '';
  };
}
