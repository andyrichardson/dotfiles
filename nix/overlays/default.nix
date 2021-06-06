{ pkgs, inputs, lib, pkgs-stable, ... }:
{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    # (import ./fingerprint.nix)
    (import ./pop-shell.nix)
    (import ./cpu-freq-monitor.nix)
    (import ./noise-suppression-for-voice.nix inputs)
    # (final: prev: {
    #   gnome = pkgs-stable.gnome3;
    #   desktops.gnome = ({config, pkgs, lib }: pkgs-stable.desktops.gnome3 { inherit config lib; pkgs = pkgs-stable; });
    # })
  ];
}
