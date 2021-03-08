({ pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fonts = [ (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" "DroidSansMono" "RobotoMono" "Hack" "SourceCodePro" ]; }) ];
  };
})