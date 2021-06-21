inputs: final: prev: {
  shade-inactive-windows = prev.stdenv.mkDerivation rec {
    pname = "shade-inactive-windows";
    uuid = "shade-inactive-windows@hepaajan.iki.fi";
    version = "1.0.0";
    src = inputs.shade-inactive-windows;
    patches = [ ./user-settings.diff ./gnome-40.diff ];
    installPhase = ''
      mkdir -p $out/share/gnome-shell/extensions/${uuid}
      cp * $out/share/gnome-shell/extensions/${uuid}
    '';
  };
}
