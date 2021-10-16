# Make some libs system wide for easy node development
{ inputs, pkgs, ... }:
with pkgs; {
  # System packages used by all profiles (including root)
  environment.systemPackages = [
    bash
    binutils
    cachix
    curl
    dbus
    envs.dev
    firefox-wayland
    git
    glxinfo
    gnupg
    howdy
    hdparm
    htop
    iperf
    libva-utils
    lm_sensors
    lsof
    lynx
    nixfmt
    neovim
    openssl
    p7zip
    pciutils
    traceroute
    tree
    udev
    unzip
    unrar
    usbutils
    wget
    which
    zip
    zsh
    xorg.xbacklight

    # Video drivers
    mesa
    ffmpeg
    libdrm
    libGL
    libva.out

    # Audio drivers
    alsaLib
    libopenaptx
    libpulseaudio
    pipewire
  ];
}
