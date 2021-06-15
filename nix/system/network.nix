{ ... }: {
  # Fix wifi firware crash and slow speeds - https://bugzilla.kernel.org/show_bug.cgi?id=213381
  boot.extraModprobeConfig = ''
    options iwlwifi disable_11ax=1
  '';

  # Networking
  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.wlp0s20f3.useDHCP = true;
  };
}
