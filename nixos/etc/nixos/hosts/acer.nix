{ config, pkgs, ... }:

{
  imports =
    [ ./acer-hardware.nix
    ];

  networking.hostName = "acer"; # Define your hostname.

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub = { enable = true; efiSupport = true; device = "/dev/sda1"; };
  boot.initrd.luks.devices = [{ name = "enc-vg"; device = "/dev/sda8"; preLVM = true; allowDiscards = true; }];

  fileSystems = [
    { mountPoint = "/"; device = "/dev/disk/by-uuid/00c80c0f-1459-4b0a-ab88-d3b9313e22e7"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "vfat"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++ import ../syncthing.nix;

  swapDevices = [ { device = "/dev/vg/swap"; } ];

  services = (import ../xserver.nix).i3;
}
