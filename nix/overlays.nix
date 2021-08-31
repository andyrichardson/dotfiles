{ inputs, system, ... }@args: [
  inputs.nur.overlay
  (final: prev:
    let
      callPackage = inputs.nixpkgs.lib.callPackageWith {
        pkgs = prev;
        inherit inputs;
        inherit system;
      };
    in {
      envs = { dev = (callPackage ./packages/envs-dev.nix { }); };
      evo4 = callPackage ./packages/evo4 { };
      gtk-title-bar = callPackage ./packages/gtk-title-bar.nix { };
      parsec = callPackage ./packages/parsec.nix { };
      pop-os-shell = callPackage ./packages/pop-os-shell.nix { };
      shade-inactive-windows =
        callPackage ./packages/shade-inactive-windows { };
      simply-workspaces = inputs.simply-workspaces.defaultPackage.${system};
      unstable =
        callPackage inputs.nixpkgs-unstable { config.allowUnfree = true; };
    })
]

