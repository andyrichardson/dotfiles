{ pkgs, ... }: {
  # User profile packages
  home.packages = with pkgs; [
    aws-vault
    awscli
    docker-compose
    # figma
    (fontforge.override { withGTK = true; })
    qemu
    screenkey
    slop
    peek
    gnome.gnome-sound-recorder
    vlc
    undervolt

    # nonfree packages
    steam
    qbittorrent
    parsec
    slack
    google-chrome
    zoom-us
    unstable._1password
    unstable._1password-gui
    discord
    reaper
  ];
}
