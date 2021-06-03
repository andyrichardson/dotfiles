{ pkgs, inputs, lib, ... }:
{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    # (import ./fingerprint.nix)
    (import ./pop-shell.nix)
    (import ./noise-suppression-for-voice.nix inputs)
  ];
}
