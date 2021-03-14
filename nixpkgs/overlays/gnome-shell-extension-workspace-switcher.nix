final: prev: {
  gnome-shell-extension-workspace-switcher = prev.stdenv.mkDerivation rec {
    pname = "gnome-shell-extension-workspace-switcher";
    version = "1.0.0";
    uuid = "workspace-switcher@tomha.github.com";

    src = prev.fetchFromGitHub {
      owner = "Tomha";
      repo = "gnome-shell-extension-workspace-switcher";
      rev = "master";
      sha256 = "sha256-q+97EBCoh4BbgYxtXY/Z3odroTPhqPXe8VFiK+KW2AI=";
    };

    patches = [
      (prev.fetchpatch {
        name = "001-fix-for-latest-gnome.patch";
        url = "https://github.com/Tomha/gnome-shell-extension-workspace-switcher/pull/6.patch";
        sha256 = "sha256-IX1Q0Gw/lvzoVf3PEz5aaslIrBC8p44aqCeWosmwPwY=";
      })
    ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/gnome-shell/extensions/${uuid}
      cp -r . $out/share/gnome-shell/extensions/${uuid}/
    '';

    meta = with prev.lib; {
      description = "GNOME Shell extension for viewing and changing the current workspace.";
      license = licenses.gpl3Plus;
      homepage =  "https://github.com/Tomha/gnome-shell-extension-workspace-switcher";
    };
  };
}