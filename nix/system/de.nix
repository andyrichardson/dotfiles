{ pkgs, username ? "andy", ... }: {
  services.xserver = {
    enable = true;
    # videoDrivers = [ "modesetting" ];
    useGlamor = true;
    libinput.enable = true;
    displayManager = {
      # Causes crash
      # autoLogin = {
      #   enable = true;
      #   user = username;
      # };
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    desktopManager.gnome = { enable = true; };
    deviceSection = ''
      Option "TearFree" "True"
    '';
    layout = "us";

    # Display scaling
    # displayManager.sessionCommands = ''
    #   xrandr --output eDP-1 --scale 1.1x1.1
    # '';

    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection

      Section "Device"
        Identifier "Intel Graphics"
        Driver "intel"
        Option "TearFree" "true"
      EndSection
    '';
  };

  security.pam.services.login.enableGnomeKeyring = true;
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    enableDefaultFonts = true; # default
    fonts = [
      pkgs.roboto
      (pkgs.nerdfonts.override {
        fonts = [
          "DejaVuSansMono"
          "DroidSansMono"
          "RobotoMono"
          "Hack"
          "SourceCodePro"
        ];
      })
    ];
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  services.printing.enable = true;
}
