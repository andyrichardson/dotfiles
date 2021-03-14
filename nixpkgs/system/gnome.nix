{ config, pkgs, lib, ... }:

{
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome3 = {
    enable = true;
  };
  services.gnome3.core-shell.enable = true;
}