{ nixpkgs, inputs, lib, ... }:

let
  test = builtins.trace inputs;
in
{
  nixpkgs.overlays = [
    (final: prev: {
    	webkitgtk = prev.webkitgtk.overrideAttrs (old: {
    	  buildInputs = [ final.libunwind ] ++ old.buildInputs;
    	});
    })
  ];
}
