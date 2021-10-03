{ pkgs, ... }: {
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # GPU virtualization - https://nixos.wiki/wiki/IGVT-g
  virtualisation.kvmgt.enable = true;
  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_8" = { uuid = [ "c2867612-1224-11ec-b68f-37d0a9a1ce40" ]; };
  };
}
