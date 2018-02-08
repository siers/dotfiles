{ config, pkgs, ... }:

{
  imports =
    [ ./acer-hardware.nix
    ];

  networking.hostName = "acer"; # Define your hostname.

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [{ name = "enc-vg"; device = "/dev/sda8"; preLVM = true; allowDiscards = true; }];

  fileSystems = [
    { mountPoint = "/"; device = "/dev/vg/root"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "ntfs"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++ import ../syncthing.nix;

  swapDevices = [ { device = "/dev/vg/swap"; } ];
}
