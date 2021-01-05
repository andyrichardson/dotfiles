flakes: { config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.bbenoist.Nix
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "theme-onedark";
        vscodeExtUniqueId = "akamud.vscode-theme-onedark";
        src = flakes.vscode-theme-onedark;
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "spell-checker";
        vscodeExtUniqueId = "streetsidesoftware.code-spell-checker";
        src = flakes.vscode-spell-checker;
      })
      # pkgs.vscode-extensions.scalameta.derp
      # pkgs.stdenv.mkDerivation { 
      #   name = "vscode-extension-theme-onedark";
      #   src = flakes.vscode-theme-onedark;
      #   vscodeExtUniqueId = "1234";
      #   configurePhase = ":";
      #   buildPhase = ":";
      #   dontPatchELF = true;
      #   dontStrip = true;
      #   buildInputs = [ pkgs.unzip ];
      #   installPhase = ''
      #     runHook preInstall
      #     mkdir -p "$out/$installPrefix"
      #     find . -mindepth 1 -maxdepth 1 | xargs -d'\n' mv -t "$out/$installPrefix/"
      #     runHook postInstall
      #   '';
      # }
    ];
  };
}