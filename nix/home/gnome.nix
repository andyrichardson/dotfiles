{ config, pkgs, lib, inputs, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Super>space";
          command = "rofi -show drun -modi drun -display-drun Apps";
          name = "Rofi Applications";
        };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
        {
          binding = "<Super><Shift>space";
          command = "rofi -show run -modi run";
          name = "Rofi Run";
        };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
        {
          binding = "<Super>period";
          command = "rofimoji -a type";
          name = "Rofi Emoji";
        };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ ]; # Disable default in favor of rofi
        minimize = [ ];
        maximize = [ ];
        close = [ "<Super>BackSpace" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-10 = [ "<Super>0" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        move-to-workspace-9 = [ "<Super><Shift>9" ];
        move-to-workspace-10 = [ "<Super><Shift>0" ];
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
        num-workspaces = 10;
      };
      "org/gnome/desktop/interface" = {
        enable-animations = false;
        text-scaling-factor = 0.9;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = false;
      };
      "org/gnome/mutter/keybindings" = { toggle-tiled-left = false; };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        switch-to-application-10 = [ ];
      };
      "org/gnome/shell" = {
        disable-extension-version-validation = true;
        enabled-extensions = with pkgs; [
          gnomeExtensions.caffeine.uuid
          pop-os-shell.uuid
          simply-workspaces.uuid
          gnomeExtensions.appindicator.uuid
          shade-inactive-windows.uuid
          "just-perfection-desktop@just-perfection"
          gnomeExtensions.just-perfection.extensionUuid
          gtk-title-bar.uuid
        ];
      };
      "org/gnome/shell/overrides" = { edge-tiling = false; };
      "org/gnome/shell/extensions/just-perfection" = {
        activities-button = false;
      };
      "org/gnome/shell/extensions/gtktitlebar" = {
        hide-window-titlebars = "always";
        restrict-to-primary-screen = false;
      };
    };
  };
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-boxes
    gnome.gnome-tweak-tool
    pop-gtk-theme
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gtk-title-bar
    simply-workspaces
    cpu-freq-monitor
    pop-os-shell
    shade-inactive-windows
    libappindicator
  ];
}
