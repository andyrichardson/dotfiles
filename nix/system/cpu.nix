{ config, pkgs, ... }: {
  services.acpid.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "intel_iommu=igfx_off"
      "i915.enable_fbc=1"
      "i915.enable_guc=3"
      "i915.enable_dc=4"
      "i915.edp_vswing=2"
      "i915.enable_gvt=1"
      "acpi=force"
      "reboot=acpi"
    ];
  };
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
  systemd.targets.sleep.enable = true;
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernate=yes
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=15min
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.lidSwitchExternalPower = "suspend-then-hibernate";

  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
}
