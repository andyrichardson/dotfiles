{ ... }: {
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  # boot.kernelParams = [ "mem_sleep_default=s2idle" ];
  # services.tlp = { enable = true; };

  powerManagement.powertop.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "powersave";
  services.undervolt = {
    enable = false;
    coreOffset = -80;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
}
