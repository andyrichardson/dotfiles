{ pkgs, ... }: {
  ## Pipewire (disabled)
  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = false; # Toggle for pipewire
  #   alsa.enable = true;
  #   pulse.enable = true;
  # };

  ## Pulseaudio (enabled)
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    daemon = {
      logLevel = "debug";
      config = {
        default-sample-rate = 48000;
        high-priority = "yes";
        realtime-scheduling = "yes";
        resample-method = "src-sinc-best-quality";
        # default-fragments = 2;
        # default-fragment-size-msec = 125;
        nice-level = -20;
        realtime-priority = 50;
      };
    };
  };
  # services.udev.packages = with pkgs; [ evo4-udev ];
}
