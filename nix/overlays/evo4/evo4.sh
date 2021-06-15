#!/bin/sh
pactl unload-module module-remap-source
pactl load-module module-remap-source source_name=alsa_input.usb-Audient_EVO4-00.mic1 source_properties="device.description='EVO4\ -\ Mic\ 1'" master=alsa_input.usb-Audient_EVO4-00.multichannel-input master_channel_map=front-left channel_map=mono remix=no
pactl load-module module-remap-source source_name=alsa_input.usb-Audient_EVO4-00.mic2 source_properties="device.description='EVO4\ -\ Mic\ 2'" master=alsa_input.usb-Audient_EVO4-00.multichannel-input master_channel_map=front-right channel_map=mono remix=no
pactl set-default-source alsa_input.usb-Audient_EVO4-00.mic1