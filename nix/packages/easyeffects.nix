{ pkgs }:
with pkgs;
let
  lv2Plugins = [
    calf # limiter, compressor exciter, bass enhancer and others
    lsp-plugins # delay
  ];
  ladspaPlugins = [
    rubberband # pitch shifting
    zam-plugins # maximizer
  ];
in stdenv.mkDerivation rec {
  pname = "easyeffects";
  version = "6.1.0";
  src = fetchFromGitHub {
    owner = "wwmm";
    repo = "easyeffects";
    rev = "v${version}";
    sha256 = "sha256-dT4Ogo1+Kc/5tZryh3JTJWmzo2Z+Y2nmgNqq8u7jTdc=";
  };
  dontUseCmakeConfigure = true;
  buildInputs = [
    appstream-glib
    meson
    ninja
    pkg-config
    libxml2
    itstool
    python3
    desktop-file-utils
    wrapGAppsHook
    cmake
    pipewire
    glib
    glibmm_2_68
    gtk4
    unstable.gtkmm4
    rubberband
    speexdsp
    nlohmann_json
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base # gst-fft
    gst_all_1.gst-plugins-good # pulsesrc
    gst_all_1.gst-plugins-bad
    lilv
    lv2
    serd
    sord
    sratom
    libbs2b
    libebur128
    libsamplerate
    libsndfile
    rnnoise
    boost
    dbus
    fftwFloat
    zita-convolver
  ];

  patchPhase = ''
    patchShebangs meson_post_install.py
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --set LV2_PATH "${lib.makeSearchPath "lib/lv2" lv2Plugins}"
      --set LADSPA_PATH "${lib.makeSearchPath "lib/ladspa" ladspaPlugins}"
    )
  '';

  # Meson is no longer able to pick up Boost automatically.
  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  meta = with lib; {
    description =
      "Limiter, compressor, convolver, equalizer and auto volume and many other plugins for PipeWire applications";
    homepage = "https://github.com/wwmm/easyeffects";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.linux;
    badPlatforms = [ "aarch64-linux" ];
  };
}
