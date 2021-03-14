{ nixpkgs, ... }:

{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
  ];
}