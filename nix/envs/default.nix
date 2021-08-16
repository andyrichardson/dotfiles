{ inputs, pkgs, ... }: { devEnv = import ./dev.nix { inherit pkgs; }; }
