flakes: { pkgs, ... }:

{
  # imports = [
  #   (./. + "/modules/alacritty.nix")
  #   (./. + "/modules/git.nix")
  #   (./. + "/modules/tmux.nix")
    # (./. + "/modules/vscode.nix")
    # (./. + "/modules/zsh.nix")
  # ];

  imports = [
    (import ./modules/alacritty.nix flakes)
    # (import ./modules/fonts.nix flakes)
    (import ./modules/git.nix flakes)
    (import ./modules/tmux.nix flakes)
    (import ./modules/vscode.nix flakes)
    (import ./modules/zsh.nix flakes)
  ];
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.username = "andyrichardson";
  home.stateVersion = "21.03";
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  home.packages = [
    pkgs.htop
    pkgs.docker
    (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" "DroidSansMono" ]; })

    # pkgs.update-nix-fetchgit
  ];
}
