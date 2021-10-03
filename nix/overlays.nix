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
      unstable =
        callPackage inputs.nixpkgs-unstable { config.allowUnfree = true; };
    })
  (final: prev:
    let
      callPackage = inputs.nixpkgs.lib.callPackageWith {
        pkgs = prev;
        inherit inputs;
        inherit system;
      };
    in {
      doppler = callPackage ./packages/doppler.nix { };
      envs = { dev = (callPackage ./packages/envs-dev.nix { }); };
      evo4 = callPackage ./packages/evo4 { };
      figma = (callPackage ./packages/figma.nix { }).override {
        fonts = [ (prev.nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
      };
      fonts = callPackage ./packages/fonts.nix { };
      gtk-title-bar = callPackage ./packages/gtk-title-bar.nix { };
      howdy = callPackage ./packages/howdy/howdy.nix { };
      ir_toggle = callPackage ./packages/howdy/ir-toggle.nix { };
      pam_python = callPackage ./packages/howdy/pam-python.nix { };
      parsec = callPackage ./packages/parsec.nix { };
      pop-os-shell = callPackage ./packages/pop-os-shell.nix { };
      shade-inactive-windows =
        callPackage ./packages/shade-inactive-windows { };
      simply-workspaces = inputs.simply-workspaces.defaultPackage.${system};

    })
]

