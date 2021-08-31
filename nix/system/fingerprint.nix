{ config, lib, pkgs, modulesPath, ... }: {
  # Specific to XPS
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  security.pam.services.xscreensaver.fprintAuth = true;
  services.udev.packages = [ pkgs.libfprint-2-tod1-goodix ];

  # Facial recognition "Windows hello"
  services.ir-toggle.enable = true;
  services.howdy = {
    enable = true;
    device = "/dev/video2";
  };
}
