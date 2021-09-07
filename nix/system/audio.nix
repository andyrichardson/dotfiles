{ pkgs, ... }:
let
  # Udev rule
  evo4-udev = pkgs.writeTextFile {
    name = "20-evo4.rules";
    destination = "/lib/udev/rules.d/20-evo4.rules";
    text = ''
      ACTION=="add", ATTRS{idVendor}=="2708", ATTRS{idProduct}=="0006" TAG+="systemd", ENV{EVO4_ALIVE}="true" ENV{SYSTEMD_USER_WANTS}+="evo4-switch@add.service"
      ACTION=="remove", ATTRS{idVendor}=="2708", ATTRS{idProduct}=="0006" TAG+="systemd", ENV{EVO4_ALIVE}="false" ENV{SYSTEMD_USER_WANTS}+="evo4-switch@remove.service"
    '';
  };
  # Command to run
  evo4-script = pkgs.writeShellScriptBin "evo4" ''
    if [[ "$1" == "add" ]]; then
      ${pkgs.pulseaudioFull}/bin/pactl load-module module-remap-source source_name=alsa_input.usb-Audient_EVO4-00.mic1 source_properties="device.description=EVO4Mic1" master=alsa_input.usb-Audient_EVO4-00.multichannel-input master_channel_map=front-left channel_map=mono remix=no
    fi
    echo "$1" > /tmp/evo4log1
    # echo "TESTING HERE"
    # echo "$EVO4_ALIVE" $EVO4_ALIVE
    # env
    # env >> /tmp/evo4log1
    # 
    # echo "SCRIPT OVER" >> /tmp/evo4log
  '';
  evo4 = pkgs.symlinkJoin {
    name = "evo4";
    paths = [ evo4-udev evo4-script ];
  };
in {
  ## Pipewire (enabled)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # Toggle for pipewire
    alsa.enable = true;
    pulse.enable = true;
    media-session.config.bluez-monitor = {
      properties = {
        "bluez5.msbc-support" = true;
        "bluez5.codecs" = [ "sbc" "aac" "ldac" "aptx" "aptx_hd" ];
      };
    };
  };
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.bluetooth.settings = {
    General = { Enable = "Source,Sink,Media,Socket"; };
  };
  environment.systemPackages = with pkgs; [ unstable.easyeffects ];

  ## Pulseaudio (disabled)
  hardware.pulseaudio = {
    enable = false;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  systemd.user.services."evo4-switch@" = {
    description = "Some description";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${evo4}/bin/evo4 %I";
    };
  };
  services.udev.packages = [ evo4 ];

}
