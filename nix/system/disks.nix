{ ... }: rec {
  fileSystems = {
    "/" = {
      device = "/dev/mapper/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };
    "/boot" = {
      device = "/dev/sysvg/nixboot";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };
    "/boot/efi" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
  };
  swapDevices = [{ device = "/dev/sysvg/swap"; }];

  services.fstrim = {
    enable = true;
    interval = "daily";
  };

  boot = {
    resumeDevice = (builtins.elemAt swapDevices 0).device;
    loader = {
      efi = { efiSysMountPoint = "/boot/efi"; };
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        enableCryptodisk = true;
      };
    };

    initrd = {
      luks.devices = {
        "nixos" = {
          device = "/dev/sysvg/nix";
          allowDiscards = true;
          preLVM = false;
        };
      };
      availableKernelModules =
        [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
