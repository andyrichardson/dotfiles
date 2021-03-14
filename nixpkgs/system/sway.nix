{ config, pkgs, lib, ... }:

let 
  startsway = pkgs.writeTextFile {
    name = "startsway";
    destination = "/bin/startsway";
    executable = true;
    text = ''
      #! ${pkgs.bash}/bin/bash

      # first import environment variables from the login manager
      systemctl --user import-environment
      # then start the service
      exec systemctl --user start sway.service
    '';
  };
in
{
  hardware.opengl.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      startsway
    ];
  };

 environment = {
    etc = {
      "sway/config".source = ./sway-config;
    };
  };
  
  networking.networkmanager.enable = true;

# Here we but a shell script into path, which lets us start sway.service (after importing the environment of the login shell).
  environment.systemPackages = [startsway];

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

  systemd.user.targets.sway-session = {
    enable = true;
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  # https://github.com/Drakulix/sway-gnome/blob/master/systemd/user/gnome-session-manager%40sway-gnome.service 
  systemd.user.services."gnome-session-manager@sway-gnome.service" = {
    enable = true;
    description = "Description=GNOME Session Manager (session: %i)";
    after = ["sway.service"];
    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.gnome3.gnome-session}/libexec/gnome-session-binary --systemd-service --session=%i";
      ExecStopPost = "${pkgs.gnome3.gnome-session-ctl}/libexec/gnome-session-ctl --shutdown";
      WantedBy = "sway.service";
    };
  };

  services.gnome3.core-shell.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome3 = {
    enable = true;
    # flashback.enableMetacity = false;
    # flashback.customSessions = [{
    #   wmName = "sway-gnome";
    #   wmLabel = "sway-gnome";
    #   wmCommand = "${pkgs.sway}";
    # }];
  };
}

  