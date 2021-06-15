final: prev: {
  pop-os-shell = prev.stdenv.mkDerivation {
    pname = "pop-os-shell";
    version = "1.5.0";
    uuid = "pop-shell@system76.com";

    src = prev.fetchFromGitHub {
      owner = "andyrichardson";
      repo = "shell";
      rev = "master";
      sha256 = "sha256-KOp/0R7P/iH52njr7JPDKd4fAoN88d/pfou2gWy5QPk=";
    };

    nativeBuildInputs = [ prev.glib prev.nodePackages.typescript prev.gjs ];

    buildInputs = [ prev.gjs ];

    makeFlags = [
      "INSTALLBASE=$(out)/share/gnome-shell/extensions PLUGIN_BASE=$(out)/share/pop-shell/launcher"
    ];

    postInstall = ''
      chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/floating_exceptions/main.js
      chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/color_dialog/main.js
    '';
  };
}
