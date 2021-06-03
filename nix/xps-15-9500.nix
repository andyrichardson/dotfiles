{ config, lib, pkgs, modulesPath, ... }:
{ 
  # Fingerprint daemon
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # Display scaling
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output eDP-1 --scale 1.1x1.1
  '';
}