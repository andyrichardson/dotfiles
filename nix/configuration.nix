{ config, pkgs, inputs ? { }, username ? "andy", ... }: {
  imports = [
    ./system/audio.nix
    ./system/cpu.nix
    ./system/de.nix
    ./system/disks.nix
    ./system/fingerprint.nix
    ./system/libs.nix
    ./system/network.nix
    ./system/packages.nix
    ./system/virt.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      # Offline rebuilds
      keep-outputs = true
      keep-derivations = true
    '';
    trustedUsers = [ "${username}" ];
    useSandbox = false; # May improve build perf
    registry.node.to = {
      type = "github";
      owner = "andyrichardson";
      repo = "nix-node";
    };
    registry.self.flake = inputs.self;
    binaryCaches =
      [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 60d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "ffmpeg-3.4.8" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.plugdev = { };
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "plugdev" "adbusers" ];
  };

  # Passwordless sudo
  security.sudo.extraRules = [{
    users = [ "${username}" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  programs.adb.enable = true;
  programs.java = { enable = true; };
  programs.steam.enable = true;
  environment.pathsToLink =
    [ "/usr" "/share" "/lib" "/bin" "/etc" "/libexec" "/var" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

