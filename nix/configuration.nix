{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

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


  services.xserver.displayManager.sessionCommands = ''
    xrandr --output eDP-1 --scale 1x1
  '';
  # Bootloader
  boot.loader = {
    efi = {
      #canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      enableCryptodisk = true;
    };
  };
  boot.kernelModules = [ "kvm-intel" ];

  # Flake support
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    binaryCaches = [ "https://cache.nixos.org/" ];
    trustedUsers = [ "andy" ];
  };
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = "nixos";
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Region/timezone
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  
  # Fonts
  fonts = {
    enableDefaultFonts = true; # default
    fonts = [
      pkgs.roboto
      (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" "DroidSansMono" "RobotoMono" "Hack" "SourceCodePro" ]; })
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # kinetic scrolling libinput support sucks atm - going with synaptics
  services.xserver.libinput.enable = true;
  # services.xserver.synaptics = {
  #  enable = true;
  #  twoFingerScroll = true;
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "andy" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
    };
  };
  security.sudo.extraRules = [{ 
    users = [ "andy" ];
    commands = [
      { 
        command = "ALL";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    bash
    htop
    curl
    wget
    vim
    firefox-wayland
    lynx
    oem-somerville-melisa-meta
    oem-somerville-meta
    usbutils
    pciutils
    wofi
    libva-utils
    virt-manager
    #tlp-config
  ];
  environment.pathsToLink = [
    "/usr"
    "/share"
    "/lib"
    "/bin"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

