{ pkgs, lib, inputs, ... }:

{
  imports = [
    (import ./modules/alacritty.nix)
    (import ./modules/dconf.nix)
    (import ./modules/git.nix)
    (import ./modules/neovim.nix)
    (import ./modules/powerline.nix)
    (import ./modules/tmux.nix)
    (import ./modules/vscode.nix)
    (import ./modules/zsh.nix)
  ];
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.username = "demo";
  home.stateVersion = "21.03";
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Temporary fix for macos Applications
  # source = https://github.com/nix-community/home-manager/issues/1341#issuecomment-761021848
  # home.activation = lib.optional lib.stdenv.isDarwin ({
  #   aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     app_folder=$(echo ~/Applications);
  #     for app in $(find "$genProfilePath/home-path/Applications" -type l); do
  #       $DRY_RUN_CMD rm -f $app_folder/$(basename $app)
  #       $DRY_RUN_CMD osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$(basename $app)\"" -e "end tell"
  #     done
  #   '';
  # });


  home.packages = with pkgs; [
    git
    curl
    htop
    gnome3.dconf-editor
    docker
    lynx
  ];
}
