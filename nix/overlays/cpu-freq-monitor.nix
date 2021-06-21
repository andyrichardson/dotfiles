final: prev: {
  cpu-freq-monitor = prev.stdenv.mkDerivation rec {
    pname = "cpu-freq-monitor";
    version = "2.0.0";
    uuid = "cpu-freq-monitor@monitor.com";

    postUnpack = ''
      patchShebangs source/scripts
    '';

    postInstall = ''
      cp -r /tmp/usr $out/
    '';

    sandbox = true;
    nativeBuildInputs =
      [ prev.glib prev.gettext prev.bash prev.zip prev.unzip ];
    # patches = [ ./cpu.patch ];
    makeFlags = [
      "MSGFMT=${prev.gettext}/bin/msgfmt"
      "GLIB_COMPILE_SCHEMAS=${prev.glib.dev}/bin/glib-compile-schemas"
      "PREFIX=/tmp/usr"
    ];

    src = prev.fetchFromGitHub {
      owner = "martin31821";
      repo = "cpupower";
      rev = "feature/modular-cpufreqctl-backends";
      sha256 = "sha256-ssAsmyMwn1/LVhfMFzB1P0x/PWWfJ+Saf1xlKDDrLs0=";
    };
  };
}
