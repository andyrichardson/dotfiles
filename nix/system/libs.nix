# Make some libs system wide for easy node development
{ pkgs, ... }:
with pkgs;
let
  libPkgs = [

  ];
  # libDirs = builtins.map (libPkg: lib.getLib "${libPkg}/lib") libPkgs;
in {
  environment.systemPackages = libPkgs;
  # environment.sessionVariables.TEST = builtins.concatStringsSep ";" libDirs;
  environment.sessionVariables.TEST = lib.makeLibraryPath libPkgs;
}
