{ inputs, system, ... }: [
  # Nixpkgs unstable
  (final: prev: { unstable = import inputs.nixpkgs-unstable prev; })
  # Envs
  (final: prev: {
    envs = { dev = (import ../envs/dev.nix { pkgs = prev; }); };
  })
  inputs.nur.overlay
  (import ./pop-shell.nix inputs)
  (import ./cpu-freq-monitor.nix)
  (import ./noise-suppression-for-voice.nix inputs)
  (import ./parsec.nix)
  # (import ./figma.nix inputs)
  (import ./evo4)
  (import ./shade-inactive-windows/default.nix inputs)
  (import ./gtk-title-bar.nix inputs)
  (final: prev: {
    simply-workspaces =
      inputs.simply-workspaces.defaultPackage."${final.system}";
  })
]

