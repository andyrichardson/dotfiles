flakes: { pkgs, lib, ... }:

{
  imports = [
    (import ./modules/alacritty.nix flakes)
    (import ./modules/git.nix flakes)
    (import ./modules/neovim.nix flakes)
    (import ./modules/powerline.nix flakes)
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

  # Temporary fix for macos Applications
  # source = https://github.com/nix-community/home-manager/issues/1341#issuecomment-761021848
  home.activation = if pkgs.stdenv.isDarwin then ({
    aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      app_folder=$(echo ~/Applications);
      for app in $(find "$genProfilePath/home-path/Applications" -type l); do
        $DRY_RUN_CMD rm -f $app_folder/$(basename $app)
        $DRY_RUN_CMD osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$(basename $app)\"" -e "end tell"
      done
    '';
  }) else null;


  home.packages = [
    pkgs.htop
    pkgs.docker
  ];
}
