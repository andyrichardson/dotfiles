{ ... }: {
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

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
