{ pkgs, lib, inputs, username, ... }:

{
  imports = [
    ./alacritty.nix
    ./dconf.nix
    ./git.nix
    ./neovim.nix
    ./powerline.nix
    ./rofi.nix
    ./tmux.nix
    ./vscode.nix
    ./zsh.nix
  ];

  home = {
    inherit username;
    stateVersion = "21.03";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      git
      curl
      htop
      docker
      lynx
      (lib.mkIf pkgs.stdenv.isLinux gnome3.dconf-editor)
    ];
  };

  programs.home-manager.enable = true;
  # fonts.fontconfig.enable = true;

  # Temporary fix for macos Applications
  # source = https://github.com/nix-community/home-manager/issues/1341#issuecomment-761021848
  home.activation = lib.mkIf pkgs.stdenv.isDarwin ({
    aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      app_folder=$(echo ~/Applications);
      for app in $(find "$genProfilePath/home-path/Applications" -type l); do
        $DRY_RUN_CMD rm -f $app_folder/$(basename $app)
        $DRY_RUN_CMD osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$(basename $app)\"" -e "end tell"
      done
    '';
  });
}
