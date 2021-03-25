{ nixpkgs, inputs, lib, ... }:

let
  test = builtins.trace inputs;
in
{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    # (import ./vscode-extensions.nix)
  ];
}