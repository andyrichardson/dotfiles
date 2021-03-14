{ config, pkgs, lib, ... }:

{
  # VirtualBox only - START
  imports = [<nixpkgs/nixos/modules/installer/virtualbox-demo.nix>];
  services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
  services.xserver.displayManager.sddm.enable = lib.mkForce false;
  # VirtualBox only - STOP

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    git
    bash
  ];
  environment.pathsToLink = [
    "/usr"
    "/share"
    "/lib"
    "/bin"
  ];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  # Let demo build as a trusted user.
  # nix.trustedUsers = [ "demo" ];

  # Mount a VirtualBox shared folder.
  # This is configurable in the VirtualBox menu at
  # Machine / Settings / Shared Folders.
  # fileSystems."/mnt" = {
  #   fsType = "vboxsf";
  #   device = "nameofdevicetomount";
  #   options = [ "rw" ];
  # };
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # \$ nix search wget

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
