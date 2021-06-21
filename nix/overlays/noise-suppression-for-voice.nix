inputs: final: prev: {
  noise-suppression-for-voice = prev.stdenv.mkDerivation {
    pname = "noise-suppression-for-voice";
    version = "1.1.0";
    src = inputs.pulse-noise-suppression-for-voice;
    nativeBuildInputs = [ prev.cmake ];
  };
}

# # Sink for sound processing
# pacmd load-module module-null-sink sink_name=mic_denoised_out rate=48000

# # Sound processing
# pacmd load-module module-ladspa-sink sink_name=mic_raw_in sink_master=mic_denoised_out label=noise_suppressor_stereo plugin=/nix/store/jq0a66vd86w6zibxc334930nljkbd1av-noise-suppression-for-voice-1.1.0/lib/ladspa/librnnoise_ladspa.so control=90

# # Route mic to sound processing module (input -> sound processing -> null sink)
# pacmd load-module module-loopback source=alsa_input.pci-0000_00_1f.3.analog-stereo sink=mic_raw_in channels=1 source_dont_move=true sink_dont_move=true latency_msec=100 adjust_time=1

# # Route denoised output (sink) to 
# pacmd load-module module-remap-source source_name="denoised" source_properties="device.description='Denoised'" master=mic_denoised_out.monitor rate=48000 channels=1

# pacmd set-default-source denoised
