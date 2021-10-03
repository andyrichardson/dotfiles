{ pkgs, ... }:
let
  # Udev rule
  evo4-udev = pkgs.writeTextFile {
    name = "20-evo4.rules";
    destination = "/lib/udev/rules.d/20-evo4.rules";
    text = ''
      ACTION=="add",    ATTRS{idVendor}=="2708", ATTRS{idProduct}=="0006", TAG+="systemd", ENV{EVO4_ALIVE}+="true",  ENV{SYSTEMD_USER_WANTS}+="evo4-switch@default.service"
    '';
  };
  # Command to run
  evo4-script = pkgs.writeShellScriptBin "evo4" ''
    ALSA_INPUT="alsa_input.usb-Audient_EVO4-00"
    ALSA_OUTPUT="alsa_output.usb-Audient_EVO4-00"

    if [[ "$1" == "start" ]]; then
      # Add single channel source (mic1)
      ${pkgs.pulseaudioFull}/bin/pactl load-module module-remap-source \
        master=$ALSA_INPUT.multichannel-input \
        master_channel_map=front-left \
        source_name=$ALSA_INPUT.mic1 \
        source_properties='node.description="Audient Evo 4 - Mic 1"' \
        channel_map=mono \
        remix=no

      # Add single channel source (mic2)
      ${pkgs.pulseaudioFull}/bin/pactl load-module module-remap-source \
        master=$ALSA_INPUT.multichannel-input \
        master_channel_map=front-right \
        source_name=$ALSA_INPUT.mic2 \
        source_properties="node.description='Audient\ Evo\ 4\ -\ Mic\ 2" \
        channel_map=mono \
        remix=no

      # Add 2 channel output (main output)
      ${pkgs.pulseaudioFull}/bin/pactl load-module module-remap-sink \
        master=$ALSA_OUTPUT.analog-surround-40 \
        master_channel_map=front-left,front-right \
        sink_name=ALSA_OUTPUT.main-output \
        sink_properties="node.description='Audient'" \
        channel_map=stereo \
        remix=no

      # Set default input
      ${pkgs.pulseaudioFull}/bin/pactl set-default-source alsa_input.usb-Audient_EVO4-00.mic1
    fi

    if [[ "$1" == "stop" ]]; then
      ${pkgs.pulseaudioFull}/bin/pactl unload-module module-remap-source
    fi
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
    description = "Evo4 device service";
    unitConfig = { StopWhenUnneeded = true; };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${evo4}/bin/evo4 start";
      ExecStop = "${evo4}/bin/evo4 stop";
      RemainAfterExit = true;
    };
  };
  services.udev.packages = [ evo4 ];

}
