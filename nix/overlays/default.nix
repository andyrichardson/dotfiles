{ pkgs, inputs, lib, pkgs-stable, ... }: {
  nixpkgs.overlays = [
    inputs.nur.overlay
    (import ./pop-shell.nix)
    (import ./cpu-freq-monitor.nix)
    (import ./noise-suppression-for-voice.nix inputs)
    (import ./parsec.nix)
    (import ./evo4)
    (import ./shade-inactive-windows/default.nix inputs)
    (final: prev: {
      simply-workspaces =
        inputs.simply-workspaces.defaultPackage."${final.system}";
    })
  ];
}
