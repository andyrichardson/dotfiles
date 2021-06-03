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
    xrandr --output eDP-1 --scale 1.2x1.2
  '';

  environment.systemPackages = with pkgs; [
    # Fingerprint packages (TODO: Add dell drivers)
    oem-somerville-melisa-meta
    oem-somerville-meta
    # tlp-config
  ];
}