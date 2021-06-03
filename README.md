# About

This is a collection of my config files and setup scripts. Feel free to use and redistribute!

## NixOS Installation

Some assumptions here about source device so keep that in mind!

### Partitioning

Partition layout should look a little something like this.

```
NAME              MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
nvme0n1           259:0    0 931.5G  0 disk
├─nvme0n1p1       259:1    0   300M  0 part  /boot/efi
└─nvme0n1p2       259:2    0 931.2G  0 part
  ├─sysvg-nixboot 254:0    0     1G  0 lvm   /boot
  ├─sysvg-nix     254:1    0   500G  0 lvm
  │ └─nixos       254:3    0   500G  0 crypt /
  └─sysvg-swap    254:2    0    15G  0 lvm   [SWAP]
```

Second partition (`nvme0n1p2`) uses LVM.

<details>
  <summary>lvdisplay output</summary>

```
--- Logical volume ---
LV Path                /dev/sysvg/nixboot
LV Name                nixboot
VG Name                sysvg
LV UUID                QGeEki-e3KY-00W4-FlYY-cUu7-ZePj-BMYvcU
LV Write Access        read/write
LV Creation host, time nixos, 2021-06-01 17:07:03 +0100
LV Status              available
# open                 1
LV Size                1.00 GiB
Current LE             256
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           254:0

--- Logical volume ---
LV Path                /dev/sysvg/nix
LV Name                nix
VG Name                sysvg
LV UUID                jgLfMW-RxfO-2f9y-EjXo-6nWB-dKrT-54h2qf
LV Write Access        read/write
LV Creation host, time nixos, 2021-06-01 17:09:28 +0100
LV Status              available
# open                 1
LV Size                500.00 GiB
Current LE             128000
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           254:1

--- Logical volume ---
LV Path                /dev/sysvg/swap
LV Name                swap
VG Name                sysvg
LV UUID                ZBmfwb-zsgz-Hpi2-TeJv-Mo2M-7HCs-NOfkNe
LV Write Access        read/write
LV Creation host, time nixos, 2021-06-01 19:40:33 +0100
LV Status              available
# open                 2
LV Size                15.00 GiB
Current LE             3840
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           254:2
```

</details>

Root partition needs to be encrypted ahead of time.

### Installation

Mount the target partitions as follows:

- `/` -> `/mnt/`
- `/boot` -> `/mnt/boot`
- `/boot/efi` -> `/mnt/boot/efi`

Copy `configuration.nix` from the `nix` folder in this repo.

> Note: Consider running `nixos-generate-config` first to see what the suggested config is

Run installation

```
nixos-install
```

## Config

### Cloning repo

Clone the repo.

```
mkdir ~/dev
cd ~/dev
git clone git@github.com:andyrichardson/dotfiles.git
git update-index --skip-worktree nix/config/secrets.nix
```

### Configuring secrets

Make sure to populate secrets in `nix/config/secrets.nix` (maybe check 1password for values)

### Linking nix config

Making a system link to the repo folder.

> Note: Consider backing up /etc/nixos first

```sh
sudo rm -r /etc/nixos
sudo ln -s ~/dotfiles/nix /etc/nixos
```

Install all the things (first run will take a while)

```sh
sudo nixos-rebuild switch
```

## SSH keys

Source SSH keys from 1Password (or wherever you've stored them) and copy them to the ~/.ssh folder

```sh
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
```
