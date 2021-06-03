{ nixpkgs, inputs, lib, ... }:
{
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    (import ./fingerprint.nix)
    (import ./pop-shell.nix)
    # (final: prev: {
    #   pop-os-shell = (inputs.popshell.lib.nixosSystem { system = "x86_64-linux"; modules = []; }).pkgs.gnomeExtensions.pop-os-shell;
    # })
    # (import ./vscode-extensions.nix)
  ];
}
