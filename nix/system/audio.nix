{ pkgs, ... }: {
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
  environment.systemPackages = with pkgs; [ pulseeffects-pw ];

  ## Pulseaudio (disabled)
  hardware.pulseaudio = {
    enable = false;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
  # services.udev.packages = with pkgs; [ evo4-udev ];
}
