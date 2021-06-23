{ config, ... }: {
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  boot.kernelParams = [ "intel_iommu=igfx_off" "i915.enable_fbc=1" ];
  services.syslogd.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEBUG = "arg bat disk lock nm path pm ps rf run sysfs udev usb";
    };
  };
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  services.undervolt = {
    enable = false;
    coreOffset = -80;
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
}
