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
          binding = "<Super>period";
          command = "rofi -show emoji -modi emoji -display-drun Emoji";
          name = "Rofi Emoji";
        };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ ]; # Disable default in favor of rofi
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
      "org/gnome/desktop/interface" = { enable-animations = false; };
      "org/gnome/mutter" = { dynamic-workspaces = false; };
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
          # gnome-shell-extension-workspace-switcher.uuid
          gnomeExtensions.caffeine.uuid
          pop-os-shell.uuid
          simply-workspaces.uuid
          "just-perfection-desktop@just-perfection"
          #gnomeExtensions.just-perfection.uuid
        ];
      };
      "org/gnome/shell/extensions/workspce-switcher" = {
        position =
          "CENTER"; # Position values - https://github.com/Tomha/gnome-shell-extension-workspace-switcher/blob/master/schema/org.gnome.shell.extensions.workspace-switcher.gschema.xml#L13
      };
      "org/gnome/shell/extensions/just-perfection" = {
        activities-button = false;
      };
    };
  };
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-boxes
    gnome.gnome-tweak-tool
    pop-gtk-theme
    #gnome-shell-extension-workspace-switcher
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection
    simply-workspaces
    pop-os-shell
    cpu-freq-monitor
  ];
}
