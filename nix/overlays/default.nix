{ nixpkgs, inputs, lib, ... }:
{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    (import ./fingerprint.nix)
  ];
}
