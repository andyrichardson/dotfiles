{ ... }: {
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
}
