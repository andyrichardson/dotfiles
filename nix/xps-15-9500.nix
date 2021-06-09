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
  security.pam.services.login.unixAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # Fix wifi firware crash and slow speeds
  # Note: Doesn't actually disable AX (tested w/ 400mbit down)
  # Forces firmware "59.601f3a66.0 QuZ-a0-hr-b0-59.ucode"
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=1 disable_11ax=1
  '';

  # Display scaling
#  services.xserver.displayManager.sessionCommands = ''
#    xrandr --output eDP-1 --scale 1.1x1.1
#  '';
}
