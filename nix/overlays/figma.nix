inputs: final: prev: {
  figma = prev.stdenv.mkDerivation rec {
    pname = "figma";
    uuid = "figma";
    version = "1.0.0";
    src = inputs.figma;
    # phases = [ "buildPhase" ];
    buildInputs = with prev; [
      nodejs
      rustc
      cargo
      tree
      python3
      freetype
      appimagekit
      p7zip
      squashfsTools
      glibc
      zlib
    ];
    configurePhase = ''
      export HOME=$TMP 
      export USE_SYSTEM_7ZA=true
      npm i
    '';
    buildPhase = ''
      echo "BUILD PHASE"
      # npm run package
    '';
    installPhase = ''
      mkdir -p $out/share/gnome-shell/extensions
      cp -r ${uuid} $out/share/gnome-shell/extensions/
    '';
  };
}
