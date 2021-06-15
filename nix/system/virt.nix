{ ... }: {
  virtualisation.docker.enable = true;

  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
}
