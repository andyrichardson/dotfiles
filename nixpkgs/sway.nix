{ config, pkgs, lib, ... }:

{
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true; # so that gtk works properly
  #   extraPackages = with pkgs; [
  #     swaylock
  #     swayidle
  #     wl-clipboard
  #     mako # notification daemon
  #     alacritty # Alacritty is the default terminal in the config
  #     dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  #   ];
  #   extraSessionCommands = ''
  #     systemctl --user import-environment
  #   '';
  # };

  networking.networkmanager.enable = true;
  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  # systemctl --user status
  systemd.user.services.sway = {
    enable = true;
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome3 = {
    enable = true;
  };
  services.gnome3.core-shell.enable = true;
  # services.wayland.displayManager.gdm.enable = true;
}