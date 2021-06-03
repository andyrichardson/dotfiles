{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./xps-15-9500.nix
  ];

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

  # Bootloader
  boot.loader = {
    efi = {
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

  # Desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  

  # Enable touchpad support (enabled default in most desktopManager).
  # kinetic scrolling support w/ libinput sucks for now
  services.xserver.libinput.enable = true;
  # services.xserver.synaptics = {
  #  enable = true;
  #  twoFingerScroll = true;
  #};

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "andy" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "libvirtd" ];
    };
  };
  # Passwordless sudo
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
    # The basics
    git
    bash
    htop
    curl
    wget
    tree
    vim
    firefox-wayland
    lynx
    usbutils
    pciutils
    libva-utils
  ];
  environment.pathsToLink = [
    "/usr"
    "/share"
    "/lib"
    "/bin"
  ];

  # Containers + virtualizaiton
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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

