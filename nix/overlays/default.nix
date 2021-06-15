{ pkgs, inputs, lib, pkgs-stable, ... }: {
  nixpkgs.overlays = [
    (import ./gnome-shell-extension-workspace-switcher.nix)
    # (import ./fingerprint.nix)
    (import ./pop-shell.nix)
    (import ./cpu-freq-monitor.nix)
    (import ./noise-suppression-for-voice.nix inputs)
    (import ./parsec.nix)
    (final: prev: {
      simply-workspaces =
        inputs.simply-workspaces.defaultPackage."${final.system}";
    })
    inputs.nur.overlay
    # (final: prev: {
    #    steam = prev.steam.override {
    #     nativeOnly = true;
    #   };
    # })  
  ];
}
