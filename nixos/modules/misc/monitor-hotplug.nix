{ config, pkgs, ... }:

with pkgs;

let
  action = writeTextFile {
    name = "udev-change-event";
    executable = true;
    text = ''
      #! ${bash}/bin/bash

      # let's just see whether this executes
      touch "/home/s/$(date +%F-%T)-monitor-hotplug-event"
    '';
  };

in

{
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", RUN+="${action}"
  '';
}

# s|~ % udevadm monitor
# monitor will print the received events for:
# UDEV - the event which udev sends out after rule processing
# KERNEL - the kernel uevent
#
# KERNEL[3570290.682806] change   /devices/pci0000:00/0000:00:02.0/drm/card0 (drm)
# UDEV  [3570290.689222] change   /devices/pci0000:00/0000:00:02.0/drm/card0 (drm)
# KERNEL[3570292.578639] change   /devices/pci0000:00/0000:00:02.0/drm/card0 (drm)
# UDEV  [3570292.582807] change   /devices/pci0000:00/0000:00:02.0/drm/card0 (drm)
